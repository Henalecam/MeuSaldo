class AddDetailsToCryptoPrices < ActiveRecord::Migration[8.1]
  def change
    add_column :crypto_prices, :name, :string
    add_column :crypto_prices, :symbol, :string
    add_column :crypto_prices, :market_cap, :decimal
  end
end
