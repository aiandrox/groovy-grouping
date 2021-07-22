class CreateAttendanceStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_statuses do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :criterion_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
