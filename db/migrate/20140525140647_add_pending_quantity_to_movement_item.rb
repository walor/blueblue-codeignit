class AddPendingQuantityToMovementItem < ActiveRecord::Migration
  def change
    add_column :movement_items, :pending_quantity, :integer
  end
end
