class AddTypeToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :type_order, :integer, :default => 1
  end
end
