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
FactoryBot.define do
  factory :criterion do
    name { "MyString" }
    priority { 1 }
    event
  end
end
