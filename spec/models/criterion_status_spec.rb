# == Schema Information
#
# Table name: criterion_statuses
#
#  id           :bigint           not null, primary key
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  criterion_id :bigint           not null
#
# Indexes
#
#  index_criterion_statuses_on_criterion_id  (criterion_id)
#
# Foreign Keys
#
#  fk_rails_...  (criterion_id => criteria.id)
#
require 'rails_helper'

RSpec.describe CriterionStatus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
