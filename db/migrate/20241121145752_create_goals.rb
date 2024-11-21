class CreateGoals < ActiveRecord::Migration[8.1]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :target_amount
      t.decimal :current_amount
      t.date :deadline
      t.boolean :achieved

      t.timestamps
    end
  end
end
