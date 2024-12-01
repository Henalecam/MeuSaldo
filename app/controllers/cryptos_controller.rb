# app/controllers/cryptos_controller.rb
class CryptosController < ApplicationController
  def index
    @cryptos = CryptoPrice.all
  end

  def show
    @crypto = CryptoPrice.find_by(crypto_id: params[:id])
    redirect_to cryptos_path, alert: "Cryptocurrency not found" if @crypto.nil?
  end

  def update_prices
    CryptoPriceService.new.update_crypto_prices
    redirect_to cryptos_path, notice: "Crypto prices updated successfully."
  rescue => e
    redirect_to cryptos_path, alert: "Failed to update prices: #{e.message}"
  end
end
