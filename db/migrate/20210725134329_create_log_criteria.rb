class CreateLogCriteria < ActiveRecord::Migration[6.1]
  def change
    create_table :log_criteria do |t|
      t.string :name, null: false
      t.integer :priority, null: false
      t.references :result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
