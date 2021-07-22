class CreateCriteria < ActiveRecord::Migration[6.1]
  def change
    create_table :criteria do |t|
      t.string :name, null: false
      t.integer :priority, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
