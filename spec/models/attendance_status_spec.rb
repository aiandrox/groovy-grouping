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
#  index_attendance_statuses_on_attendance_id        (attendance_id)
#  index_attendance_statuses_on_criterion_status_id  (criterion_status_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendance_id => attendances.id)
#  fk_rails_...  (criterion_status_id => criterion_statuses.id)
#
require 'rails_helper'

RSpec.describe AttendanceStatus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
