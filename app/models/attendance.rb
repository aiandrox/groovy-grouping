# == Schema Information
#
# Table name: attendances
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_attendances_on_event_id  (event_id)
#  index_attendances_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
class Attendance < ApplicationRecord
  has_many :attendance_statuses, dependent: :destroy
  has_many :criterion_statuses, through: :attendance_statuses
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: [:event_id] }

  def user_name
    user&.name || '削除済みユーザー'
  end
end
