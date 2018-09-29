class AddFieldsToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :observations, :text
    add_column :purchase_orders, :validity, :string
    add_column :purchase_orders, :delivery, :string
    add_column :purchase_orders, :pay_form, :string
  end
end
