class AddPurchaseOrderIdToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :purchase_order_id, :integer
  end
end
