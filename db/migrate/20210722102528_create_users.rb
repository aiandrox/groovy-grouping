class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.references :team, null: false, index: false, foreign_key: true

      t.timestamps
    end
    add_index :users, [:team_id, :name, :active], unique: true
  end
end
