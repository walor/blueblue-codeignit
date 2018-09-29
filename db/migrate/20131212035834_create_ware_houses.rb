class CreateWareHouses < ActiveRecord::Migration
  def change
    create_table :ware_houses do |t|
      t.string :name
      t.integer :responsible_id

      t.timestamps
    end
  end
end
