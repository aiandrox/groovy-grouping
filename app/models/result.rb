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
  has_many :log_criteria, dependent: :destroy
  belongs_to :event

  def self.group(event)
    transaction do
      result = create!(
        group_count: event.group_count,
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
      result
    end
  end

  def to_param
    uuid
  end

  def grouped_attendance_ids
    if event.criteria.present?
      event.attendances.joins(attendance_statuses: :criterion_status).group_by(&:criterion_status_ids)
    else
      event.attendance_ids.shuffle.in_groups(event.group_count, false)
    end
  end
end
