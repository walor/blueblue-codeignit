class AddBrandToRequerimentItem < ActiveRecord::Migration
  def change
    add_column :requeriment_items, :brand_id, :integer, :references => :brands
  end
end
