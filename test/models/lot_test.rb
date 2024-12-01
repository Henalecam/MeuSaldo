# == Schema Information
#
# Table name: lots
#
#  id              :bigint           not null, primary key
#  errata_warnings :string
#  lot_number      :string
#  min_price       :string
#  person          :string
#  status          :string
#  type            :string
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
require "test_helper"

class LotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
