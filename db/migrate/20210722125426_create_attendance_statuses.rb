class CreateAttendanceStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_statuses do |t|
      t.references :attendance, null: false, index: false, foreign_key: true
      t.references :criterion_status, null: false, foreign_key: true
      t.references :criterion, null: false, index: false, foreign_key: true

      t.timestamps
    end
    add_index :attendance_statuses, [:criterion_id, :attendance_id], unique: true
  end
end
