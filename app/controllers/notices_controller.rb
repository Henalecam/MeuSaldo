class NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.includes(:lots).find(params[:id])
  end

  def search
    @results = Lot.where("lot LIKE ?", "%#{params[:query]}%")
  end

  def create
    # Here you can handle the logic to save the notice.
    notice = Notice.new(notice_params)

    if notice.save
      render json: notice, status: :created
    else
      render json: { errors: notice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:code, :description, :start_date, :end_date, :lots_count)
  end
end
