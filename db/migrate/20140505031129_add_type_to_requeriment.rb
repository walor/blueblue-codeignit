class AddTypeToRequeriment < ActiveRecord::Migration
  def change
    add_column :requeriments, :type, :boolean
  end
end
