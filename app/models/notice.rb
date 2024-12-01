# == Schema Information
#
# Table name: notices
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :string
#  end_date    :date
#  link        :string
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Notice < ApplicationRecord
end
