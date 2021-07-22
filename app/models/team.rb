# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  edit_uuid  :string(255)      not null
#  name       :string(255)      default("未設定"), not null
#  ref_uuid   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Team < ApplicationRecord
  before_create :set_uuids

  validates :name, presence: true, length: { maximum: 50 }
  validates :ref_uuid, presence: true, uniqueness: true
  validates :edit_uuid, presence: true, uniqueness: true

  private

  def set_uuids
    self.ref_uuid = SecureRandom.urlsafe_base64(9)
    self.edit_uuid = SecureRandom.urlsafe_base64(9)
  end
end
