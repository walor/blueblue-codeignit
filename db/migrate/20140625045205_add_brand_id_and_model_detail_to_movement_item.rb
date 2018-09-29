class AddBrandIdAndModelDetailToMovementItem < ActiveRecord::Migration
  def change
    add_column :movement_items, :brand_id, :integer, references: :brands
    add_column :movement_items, :model, :string
    add_column :movement_items, :detail, :string
    add_column :purchase_details, :model, :string
    add_column :purchase_details, :detail, :string
    add_column :purchase_details, :brand_id, :integer, references: :brands
  end
end