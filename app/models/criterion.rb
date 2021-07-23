# == Schema Information
#
# Table name: criteria
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  priority   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_criteria_on_event_id_and_priority  (event_id,priority) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Criterion < ApplicationRecord
  has_many :criterion_statuses, dependent: :destroy
  belongs_to :event

  validates :name, presence: true, length: { maximum: 50 }
  validates :priority, presence: true, uniqueness: { scope: [:event_id] }
  validate :criterion_count_validate, on: :create

  def save_with_statuses(status_names)
    return false if invalid?

    transaction do
      save!
      status_names.each do |name|
        criterion_statuses.create!(name: name)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:statuses, e.record.errors.messages.values.join)
    false
  end

  private

  def criterion_count_validate
    errors.add(:base, "条件は1つしか設定できません") if event.criteria.count >= 1
  end
end
