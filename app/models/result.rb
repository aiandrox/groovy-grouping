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

      grouped_attendances(event).each do |attendances|
        group = result.groups.create!
        attendances.each do |attendance|
          group.group_users.create!(user_name: attendance.user_name, user_id: attendance.user_id)
        end
      end
      result
    end
  end

  def self.grouped_attendances(event)
    if event.criteria.present?
      attendances_hash = event.attendances.joins(attendance_statuses: :criterion_status).group_by(&:criterion_status_ids)
      attendances = attendances_hash.to_a.shuffle.map do |criterion_status_ids, attendances|
        attendances.shuffle
      end.flatten
      group_array = GroupArray.new(attendances)
      group_array.divide_smooth(event.group_count)
    else
      event.attendances.shuffle.in_groups(event.group_count, false)
    end
  end

  def to_param
    uuid
  end
end
