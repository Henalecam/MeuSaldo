class AddLotsCountToNotices < ActiveRecord::Migration[8.1]
  def change
    add_column :notices, :lots_count, :integer
  end
end
