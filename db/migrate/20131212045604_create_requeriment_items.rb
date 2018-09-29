class CreateRequerimentItems < ActiveRecord::Migration
  def change
    create_table :requeriment_items do |t|
      t.references :requeriment
      t.references :product
      t.float :quantity

      t.timestamps
    end
    add_index :requeriment_items, :requeriment_id
    add_index :requeriment_items, :product_id
  end
end
