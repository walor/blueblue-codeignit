class AddRemoveFieldsToProduct < ActiveRecord::Migration
  def up
    remove_column :products, :barcode
    remove_column :products, :photo_url
    remove_column :products, :size
    remove_column :products, :color
    remove_column :products, :long_description

    remove_column :products, :brand_id
    remove_column :products, :generic_product_id

    remove_column :products, :serial_number
    remove_column :products, :model
  end

  def down
    add_column :products, :barcode, :string
    add_column :products, :photo_url, :string
    add_column :products, :size, :string
    add_column :products, :color, :string
    add_column :products, :long_description, :text

    add_column :products, :brand_id, :integer, references: :brands
    add_column :products, :generic_product_id, :integer, references: :generic_products

    add_column :products, :serial_number, :string
    add_column :products, :model, :string
  end
end
