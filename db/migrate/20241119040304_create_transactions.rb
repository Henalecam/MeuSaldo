class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.references :category, null: false, foreign_key: true
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
