class CreateNotices < ActiveRecord::Migration[8.1]
  def change
    create_table :notices do |t|
      t.string :code
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :link

      t.timestamps
    end
  end
end
