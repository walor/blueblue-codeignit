class AddObservationToRequeriment < ActiveRecord::Migration
  def change
    add_column :requeriments, :observation, :text
  end
end
