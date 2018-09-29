class CreateProductWareHouses < ActiveRecord::Migration
  def change
    create_table :product_ware_houses do |t|
      t.references :product
      t.references :ware_house
      t.float :current_stock, default: 0

      t.timestamps
    end
    add_index :product_ware_houses, :product_id
    add_index :product_ware_houses, :ware_house_id
  end
end
