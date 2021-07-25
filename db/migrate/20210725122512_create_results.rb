class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :member_count, null: false
      t.string :uuid, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
