# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  result_id  :bigint           not null
#
# Indexes
#
#  index_groups_on_result_id  (result_id)
#
# Foreign Keys
#
#  fk_rails_...  (result_id => results.id)
#
FactoryBot.define do
  factory :group do
    result
  end
end
