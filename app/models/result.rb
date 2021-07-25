# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  setting    :json             not null
#  uuid       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
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
  belongs_to :event

  def self.group(event)
    if event.criteria.present?
      event.attendances.joins(attendance_statuses: :criterion_status).group_by(&:criterion_status_ids)
    else
      event.attendances.shuffle
    end
  end
end
