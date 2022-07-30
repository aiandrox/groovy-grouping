class RemoveCriterionIdFromAttendanceStatuses < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :attendance_statuses, :criteria
    remove_index :attendance_statuses, name: :index_attendance_statuses_on_criterion_id_and_attendance_id
    remove_column :attendance_statuses, :criterion_id
    add_index :attendance_statuses, [:criterion_status_id, :attendance_id], unique: true, name: :index_attendance_statuses_on_criterion_status_and_attendance
  end
end
