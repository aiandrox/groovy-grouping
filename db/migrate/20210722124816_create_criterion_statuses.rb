class CreateCriterionStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :criterion_statuses do |t|
      t.string :name, null: false
      t.references :criterion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
