# == Schema Information
#
# Table name: lots
#
#  id              :bigint           not null, primary key
#  errata_warnings :string
#  lot_number      :string
#  lot_type        :string
#  min_price       :string
#  person          :string
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notice_id       :bigint           not null
#
# Indexes
#
#  index_lots_on_notice_id  (notice_id)
#
# Foreign Keys
#
#  fk_rails_...  (notice_id => notices.id)
#
# app/models/lot.rb
class Lot < ApplicationRecord
  belongs_to :notice
  validates :lot_number, :min_price, :lot_type, :status, :person, presence: true
end
