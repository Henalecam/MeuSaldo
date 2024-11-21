# == Schema Information
#
# Table name: goals
#
#  id             :bigint           not null, primary key
#  achieved       :boolean
#  current_amount :decimal(, )
#  deadline       :date
#  name           :string
#  target_amount  :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_goals_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Goal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }
end
