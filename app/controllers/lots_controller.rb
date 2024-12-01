# app/controllers/lots_controller.rb
class LotsController < ApplicationController
  def create
    # Here you can handle the logic to save the lot.
    lot = Lot.new(lot_params)

    if lot.save
      render json: lot, status: :created
    else
      render json: { errors: lot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def lot_params
    params.require(:lot).permit(:notice_id, :lot_number, :min_price, :lot_type, :status, :person, :errata_warnings)
  end
end
