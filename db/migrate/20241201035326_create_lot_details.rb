class CreateLotDetails < ActiveRecord::Migration[8.1]
  def change
    create_table :lot_details do |t|
      t.references :lot, null: false, foreign_key: true
      t.string :venue
      t.string :quantity
      t.string :unit
      t.string :description

      t.timestamps
    end
  end
end
