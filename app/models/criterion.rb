# == Schema Information
#
# Table name: criteria
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  primary    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_criteria_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Criterion < ApplicationRecord
  belongs_to :event

  validates :name, presence: true, length: { maximum: 50 }
  validates :primary, presence: true
end
