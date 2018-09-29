class AddStatusToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :status, :integer
  end
end
