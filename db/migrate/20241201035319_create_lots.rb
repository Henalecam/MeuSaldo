class CreateLots < ActiveRecord::Migration[8.1]
  def change
    create_table :lots do |t|
      t.references :notice, null: false, foreign_key: true
      t.string :lot_number
      t.string :min_price
      t.string :type
      t.string :status
      t.string :person
      t.string :errata_warnings

      t.timestamps
    end
  end
end
