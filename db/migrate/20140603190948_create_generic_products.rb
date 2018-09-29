class CreateGenericProducts < ActiveRecord::Migration
  def change
    create_table :generic_products do |t|
      t.references :category
      t.string :name
      t.string :description
      t.string :measurement_unit
      t.integer :generic_product_type
      t.timestamps
    end
  end
end