class AddAvgPriceToProductWareHouse < ActiveRecord::Migration
  def change
    add_column :product_ware_houses, :avg_price, :float
  end
end
