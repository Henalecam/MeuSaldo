# == Schema Information
#
# Table name: notices
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :string
#  end_date    :date
#  link        :string
#  lots_count  :integer
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Notice < ApplicationRecord
  has_many :lots
  validates :code, :description, :start_date, :end_date, :lots_count, presence: true
end
