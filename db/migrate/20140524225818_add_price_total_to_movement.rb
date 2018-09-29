class AddPriceTotalToMovement < ActiveRecord::Migration
  def change
  	add_column :movement_items, :price_total, :float, default: 0
  end
end
