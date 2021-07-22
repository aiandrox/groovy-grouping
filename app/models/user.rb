# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_users_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class User < ApplicationRecord
  belongs_to :team

  has_many :attendances, dependent: :nullify
  has_many :events, through: :attendances

  validates :name, presence: true, length: { maximum: 50 }
end
