class AddImplicatedToProductWareHouse < ActiveRecord::Migration
  def change
    add_column :product_ware_houses, :implicate, :float, default: 0.0
  end
end