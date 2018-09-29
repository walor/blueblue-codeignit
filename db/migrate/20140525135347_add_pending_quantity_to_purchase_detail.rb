class AddPendingQuantityToPurchaseDetail < ActiveRecord::Migration
  def change
    add_column :purchase_details, :pending_quantity, :integer
  end
end
