class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(date: :desc).limit(10)
    @categories = current_user.categories
    @budget = current_user.budgets.find_by(month: Date.today.month, year: Date.today.year)
  end
end
