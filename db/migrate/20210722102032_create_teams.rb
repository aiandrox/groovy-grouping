class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :ref_uuid, null: false
      t.string :edit_uuid, null: false

      t.timestamps
    end
  end
end
