class AddCenterCostToWareHouse < ActiveRecord::Migration
  def change
    add_column :ware_houses, :cost_center, :string
  end
end
