class AddPurchaseOrderFieldsToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :invoice_number, :string
    add_column :movements, :invoice_date, :datetime
  end
end
