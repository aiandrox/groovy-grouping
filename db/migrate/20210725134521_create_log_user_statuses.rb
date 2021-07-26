class CreateLogUserStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :log_user_statuses do |t|
      t.string :status_name, null: false
      t.references :group_user, null: false, foreign_key: true
      t.references :log_criterion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
