class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.string :name
      t.datetime :date
      t.references :provider
      t.references :ware_house
      t.references :product
      t.references :movement_type
      t.float :quantity
      t.integer :emisor_id
      t.integer :receiver_id
      t.integer :status
      t.float :price_unit

      t.timestamps
    end
    add_index :movements, :ware_house_id
    add_index :movements, :product_id
    add_index :movements, :movement_type_id
  end
end
