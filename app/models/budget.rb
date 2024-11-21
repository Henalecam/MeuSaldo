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
class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :limit, presence: true, numericality: { greater_than: 0 }
end
