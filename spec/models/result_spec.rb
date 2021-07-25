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
require 'rails_helper'

RSpec.describe Result, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
