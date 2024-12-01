class CreateCryptoPrices < ActiveRecord::Migration[8.1]
  def change
    create_table :crypto_prices do |t|
      t.string :crypto_id
      t.decimal :price

      t.timestamps
    end
  end
end
