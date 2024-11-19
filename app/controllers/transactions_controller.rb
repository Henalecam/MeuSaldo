class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(date: :desc)
  end

  def new
    @transaction = current_user.transactions.build
    @categories = current_user.categories
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: "Transação criada com sucesso."
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :category_id, :description, :date)
  end
end
