# == Schema Information
#
# Table name: budgets
#
#  id         :bigint           not null, primary key
#  limit      :decimal(, )
#  month      :integer
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class BudgetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
