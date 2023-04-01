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

      assigner = GroupAssigner.new(event)
      group_users = assigner.assign_groups.map do |attendances|
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

  def to_param
    uuid
  end
end
