# app/services/crypto_price_service.rb
class CryptoPriceService
  include HTTParty
  base_uri 'https://api.coingecko.com/api/v3'

  def update_crypto_prices
    response = self.class.get("/coins/markets", query: { vs_currency: 'brl' })
    return unless response.success?

    response.parsed_response.each do |crypto|
      CryptoPrice.find_or_initialize_by(crypto_id: crypto["id"]).tap do |record|
        record.name = crypto["name"]
        record.symbol = crypto["symbol"]
        record.price = crypto["current_price"]
        record.market_cap = crypto["market_cap"]
        record.save!
      end
    end
  end
end
