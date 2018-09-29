class InitialCloseToWareHouse < ActiveRecord::Migration
  def change
    add_column :ware_houses, :initial, :boolean, default: true
    add_column :ware_houses, :close, :boolean, default: false
  end
end
