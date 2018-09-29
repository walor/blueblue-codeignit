class AddQuotationIdToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :quotation_id, :integer
  end
end
