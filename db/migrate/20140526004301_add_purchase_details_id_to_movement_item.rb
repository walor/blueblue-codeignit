class AddPurchaseDetailsIdToMovementItem < ActiveRecord::Migration
  def change
    add_column :movement_items, :purchase_detail_id, :integer, references: :purchase_details
  end
end
