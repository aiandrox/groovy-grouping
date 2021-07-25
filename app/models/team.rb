# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  edit_uuid  :string(255)      not null
#  name       :string(255)      not null
#  ref_uuid   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Team < ApplicationRecord
  before_validation :set_uuids

  has_many :users, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
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
