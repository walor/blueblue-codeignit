class CreatePurchaseDetails < ActiveRecord::Migration
  def change
    create_table :purchase_details do |t|
      t.references :purchase_order
      t.references :product
      t.string :product_name
      t.text :product_description
      t.float :quantity, default: 1
      t.float :price_unit, default: 0
      t.float :price_total, default: 0

      t.timestamps
    end
    add_index :purchase_details, :purchase_order_id
    add_index :purchase_details, :product_id
  end
end
