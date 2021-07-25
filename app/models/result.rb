# == Schema Information
#
# Table name: results
#
#  id           :bigint           not null, primary key
#  member_count :integer          not null
#  uuid         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  event_id     :bigint           not null
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
  has_many :log_criteria, dependent: :destroy
  belongs_to :event

  def self.group(event)
    if event.criteria.present?
      event.attendances.joins(attendance_statuses: :criterion_status).group_by(&:criterion_status_ids)
    else
      grouped_attendance_ids = event.attendance_ids.in_groups_of(event.member_count, false)
      transaction do
        result = create!(
          member_count: event.member_count,
          uuid: SecureRandom.urlsafe_base64(9),
          event_id: event.id
        )

        grouped_attendance_ids.each do |attendance_ids|
          group = result.groups.create!
          attendance_ids.each do |attendance_id|
            attendance = Attendance.find(attendance_id)
            group.group_users.create!(user_name: attendance.user_name, user_id: attendance.user_id)
          end
        end
      end
    end
  end
end
