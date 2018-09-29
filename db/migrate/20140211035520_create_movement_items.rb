class CreateMovementItems < ActiveRecord::Migration
  def change
    create_table :movement_items do |t|
      t.references :movement
      t.references :product
      t.string :product_name
      t.float :quantity, default: 0
      t.float :price_unit, default: 0

      t.timestamps
    end
    add_index :movement_items, :movement_id
    add_index :movement_items, :product_id
  end
end
