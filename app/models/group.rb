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
class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  belongs_to :result
end
