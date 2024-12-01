# == Schema Information
#
# Table name: lot_details
#
#  id          :bigint           not null, primary key
#  description :string
#  quantity    :string
#  unit        :string
#  venue       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lot_id      :bigint           not null
#
# Indexes
#
#  index_lot_details_on_lot_id  (lot_id)
#
# Foreign Keys
#
#  fk_rails_...  (lot_id => lots.id)
#
class LotDetail < ApplicationRecord
  belongs_to :lot
end
