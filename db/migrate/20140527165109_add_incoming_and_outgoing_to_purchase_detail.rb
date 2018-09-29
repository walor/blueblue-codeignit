class AddIncomingAndOutgoingToPurchaseDetail < ActiveRecord::Migration
  def change
    add_column :purchase_details, :incoming, :integer
    add_column :purchase_details, :outgoing, :integer
  end
end
