class AddFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :barcode, :string
    add_column :products, :photo_url, :string
    add_column :products, :size, :string
    add_column :products, :color, :string
    add_column :products, :long_description, :text

    add_column :products, :brand_id, :integer, references: :brands
    add_column :products, :generic_product_id, :integer, references: :generic_products
  end
end
