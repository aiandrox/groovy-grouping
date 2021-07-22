# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  edit_uuid  :string(255)      not null
#  name       :string(255)      default("未設定"), not null
#  ref_uuid   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_events_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Event < ApplicationRecord
  before_create :set_uuids

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  belongs_to :team

  validates :name, presence: true, length: { maximum: 50 }
  validates :ref_uuid, presence: true, uniqueness: true
  validates :edit_uuid, presence: true, uniqueness: true

  private

  def set_uuids
    self.ref_uuid = SecureRandom.urlsafe_base64(9)
    self.edit_uuid = SecureRandom.urlsafe_base64(9)
  end
end
