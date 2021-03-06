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
require 'rails_helper'

RSpec.describe Criterion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
