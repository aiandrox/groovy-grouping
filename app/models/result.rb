# == Schema Information
#
# Table name: results
#
#  id          :bigint           not null, primary key
#  group_count :integer          not null
#  uuid        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :bigint           not null
#
# Indexes
#
#  index_results_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Result < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :group_users, through: :groups
  has_many :log_criteria, dependent: :destroy
  belongs_to :event

  def self.group(event)
    transaction do
      result = create!(
        group_count: event.group_count,
        uuid: SecureRandom.urlsafe_base64(9),
        event_id: event.id,
      )

      group_users = grouped_attendances(event).map do |attendances|
        group = result.groups.create!
        attendances.map do |attendance|
          group.group_users.create!(user_name: attendance.user_name, user_id: attendance.user_id)
        end
      end.flatten

      # ログ作成
      event.criteria.each do |criterion|
        log_criterion = result.log_criteria.create!(
          name: criterion.name,
          priority: criterion.priority,
        )
        criterion.attendance_statuses.each do |attendance_status|
          group_user = group_users.detect do |group_user|
            group_user.user_id == attendance_status.attendance.user_id
          end

          log_criterion.log_user_statuses.create!(
            status_name: attendance_status.criterion_status.name,
            group_user_id: group_user.id,
          )
        end
      end
      result
    end
  end


def self.grouped_attendances(event)
  if event.criteria.present?
    attendances = event.attendances.includes(:criterion_statuses).to_a

    groups = assign_attendances_to_groups(attendances, event.group_count, event.criteria)

    max_group_size = groups.max_by(&:size).size
    min_group_size = groups.min_by(&:size).size

    # グループの人数の最大人数と最少人数の差が2人以上の場合は再帰
    if max_group_size - min_group_size >= 2
      grouped_attendances(event)
    else
      groups
    end
  else
    event.attendances.shuffle.in_groups(event.group_count, false)
  end
end

def self.assign_attendances_to_groups(attendances, group_count, criteria)
  attendances.shuffle!

  groups = Array.new(group_count) { [] }
  sorted_criteria = criteria.sort_by(&:priority).reverse

  sorted_criteria.each do |criterion|
    criterion_attendances = attendances.select do |attendance|
      attendance.criterion_statuses.any? { |status| status.criterion_id == criterion.id }
    end

    assign_criterion_attendances(groups, criterion_attendances)
    attendances -= criterion_attendances
  end

  assign_remaining_attendances(groups, attendances)
  groups
end

def self.assign_criterion_attendances(groups, criterion_attendances)
  criterion_attendances.each do |attendance|
    target_group = select_target_group(groups, attendance)
    target_group << attendance
  end
end

def self.assign_remaining_attendances(groups, attendances)
  attendances.each do |attendance|
    target_group = select_target_group(groups, attendance)
    target_group << attendance
  end
end

def self.select_target_group(groups, attendance)
  min_group_size = groups.min_by(&:size).size
  groups.select { |group| group.size <= min_group_size + 1 }.min_by do |group|
    group.count { |group_attendance| attendance.criterion_status_ids == group_attendance.criterion_status_ids }
  end
end


  def to_param
    uuid
  end
end
