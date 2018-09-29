class CreateQuotationItems < ActiveRecord::Migration
  def change
    create_table :quotation_items do |t|
      t.references :quotation
      t.references :product
      t.references :brand
      t.float :quantity
      t.string :model
      t.string :detail
      t.float :cost_unit
      t.float :cost_total

      t.timestamps
    end
    add_index :quotation_items, :quotation_id
    add_index :quotation_items, :product_id
  end
end