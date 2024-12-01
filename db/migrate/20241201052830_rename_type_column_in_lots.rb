class RenameTypeColumnInLots < ActiveRecord::Migration[8.1]
  def change
    rename_column :lots, :type, :lot_type
  end
end
