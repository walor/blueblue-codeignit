class AddColorSizeModelToRequerimentItem < ActiveRecord::Migration
  def change
    add_column :requeriment_items, :color, :string
    add_column :requeriment_items, :size, :string
    add_column :requeriment_items, :model, :string
  end
end
