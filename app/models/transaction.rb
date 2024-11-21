# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  amount      :decimal(, )
#  date        :datetime
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_transactions_on_category_id  (category_id)
#  index_transactions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Transaction < ApplicationRecord
  after_create :update_budget
  after_save :update_goal_progress

  belongs_to :user
  belongs_to :category

  private

  def update_budget
    budget = Budget.find_by(user: user, category: category)
    return unless budget

    budget.current_spent = category.transactions.sum(:amount)
    budget.save
  end

  def update_goal_progress
    goals = Goal.where(user: user)
    goals.each do |goal|
      goal.current_amount = user.transactions.sum(:amount)
      goal.save
    end
  end
end
