# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_users_on_team_id_and_name_and_active  (team_id,name,active) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class User < ApplicationRecord
  belongs_to :team
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: [:team_id, :active] }

  scope :active, -> { where(active: true) }

  def deactive!
    update!(name: "#{name}_#{id}", active: false)
  end
end
