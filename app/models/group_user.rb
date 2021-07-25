# == Schema Information
#
# Table name: group_users
#
#  id         :bigint           not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_group_users_on_group_id  (group_id)
#  index_group_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
class GroupUser < ApplicationRecord
  has_many :log_user_statuses, dependent: :destroy
  belongs_to :group
  belongs_to :user

  validates :user_name, presence: true
end
