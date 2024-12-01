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
require "test_helper"

class CryptoPriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
