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
    attendances.shuffle!

    groups = Array.new(event.group_count) { [] }

    # priorityの降順でcriteriaをソート
    sorted_criteria = event.criteria.sort_by(&:priority).reverse

    sorted_criteria.each do |criterion|
      # 各criterionに対応する出席を取得
      criterion_attendances = attendances.select do |attendance|
        attendance.criterion_statuses.any? { |status| status.criterion_id == criterion.id }
      end

      # グループに出席を追加
      criterion_attendances.each do |attendance|
        # 各グループで同じcriterion_statusが最小のものを選択
        target_group = groups.min_by do |group|
          group.count { |group_attendance| attendance.criterion_status_ids == group_attendance.criterion_status_ids }
        end

        # グループの人数が均一になるように出席を追加
        min_group_size = groups.min_by(&:size).size
        target_group = groups.select { |group| group.size <= min_group_size + 1 }.min_by do |group|
          group.count { |group_attendance| attendance.criterion_status_ids == group_attendance.criterion_status_ids }
        end

        target_group << attendance
        attendances.delete(attendance) # 重複するattendanceを削除
      end
    end

    # 未割り当ての出席を追加
    attendances.each do |attendance|
      min_size_group = groups.min_by(&:size)
      min_size_group << attendance
    end

    groups
  else
    event.attendances.shuffle.in_groups(event.group_count, false)
  end
end

  def to_param
    uuid
  end
end
