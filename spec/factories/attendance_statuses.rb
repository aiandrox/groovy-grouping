# == Schema Information
#
# Table name: attendance_statuses
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  attendance_id       :bigint           not null
#  criterion_status_id :bigint           not null
#
# Indexes
#
#  fk_rails_d4f476a0f0                                           (attendance_id)
#  index_attendance_statuses_on_criterion_status_and_attendance  (criterion_status_id,attendance_id) UNIQUE
#  index_attendance_statuses_on_criterion_status_id              (criterion_status_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendance_id => attendances.id)
#  fk_rails_...  (criterion_status_id => criterion_statuses.id)
#
FactoryBot.define do
  factory :attendance_status do
    attendance
    criterion_status
  end
end
