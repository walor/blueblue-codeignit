class AddRequerimentTypeToRequeriment < ActiveRecord::Migration
  def change
    add_column :requeriments, :type_requeriment, :integer
  end
end
