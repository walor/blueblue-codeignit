class AddColumnNameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :serial_number, :string
    add_column :products, :restock, :integer
    add_column :products, :measurement_unit_id, :integer
    add_column :products, :model, :string
  end
end
