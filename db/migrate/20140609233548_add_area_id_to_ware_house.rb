class AddAreaIdToWareHouse < ActiveRecord::Migration
  def change
    add_column :ware_houses, :area_id, :integer, :references => :areas
  end
end
