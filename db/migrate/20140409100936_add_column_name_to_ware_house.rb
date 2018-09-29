class AddColumnNameToWareHouse < ActiveRecord::Migration
  def change
    add_column :ware_houses, :telephone, :string, null: true
    add_column :ware_houses, :address, :string, null: true
    add_column :ware_houses, :description, :string, null: true
  end
end
