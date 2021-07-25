# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  edit_uuid   :string(255)      not null
#  group_count :integer
#  name        :string(255)      not null
#  ref_uuid    :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  team_id     :bigint           not null
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
  before_validation :set_uuids

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  has_many :criteria, dependent: :destroy
  has_many :results, dependent: :destroy
  belongs_to :team

  validates :name, presence: true, length: { maximum: 50 }
  validates :group_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ref_uuid, presence: true, uniqueness: true
  validates :edit_uuid, presence: true, uniqueness: true

  def to_param
    edit_uuid
  end

  private

  def set_uuids
    self.ref_uuid = ref_uuid || SecureRandom.urlsafe_base64(9)
    self.edit_uuid = edit_uuid || SecureRandom.urlsafe_base64(9)
  end
end
