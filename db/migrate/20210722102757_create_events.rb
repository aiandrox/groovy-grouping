class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.integer :member_count
      t.string :ref_uuid, null: false
      t.string :edit_uuid, null: false
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
