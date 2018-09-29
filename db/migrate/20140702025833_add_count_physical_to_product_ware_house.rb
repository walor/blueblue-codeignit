class AddCountPhysicalToProductWareHouse < ActiveRecord::Migration
  def change
    add_column :product_ware_houses, :count_physical, :float, default: 0.0
  end
end
