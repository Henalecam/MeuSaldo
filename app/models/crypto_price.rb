# == Schema Information
#
# Table name: crypto_prices
#
#  id         :bigint           not null, primary key
#  market_cap :decimal(, )
#  name       :string
#  price      :decimal(, )
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  crypto_id  :string
#
class CryptoPrice < ApplicationRecord
end
