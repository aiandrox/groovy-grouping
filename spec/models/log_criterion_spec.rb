# == Schema Information
#
# Table name: log_criteria
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  priority   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  result_id  :bigint           not null
#
# Indexes
#
#  index_log_criteria_on_result_id  (result_id)
#
# Foreign Keys
#
#  fk_rails_...  (result_id => results.id)
#
require 'rails_helper'

RSpec.describe LogCriterion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
