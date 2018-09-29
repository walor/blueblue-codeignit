class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :name
      t.references :provider
      t.date :date
      t.float :sub_total, default: 0
      t.float :total, default: 0

      t.timestamps
    end
    add_index :purchase_orders, :provider_id
  end
end
