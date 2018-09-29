class AddObservationsToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :observation, :text
    add_column :movements, :serial, :string
  end
end
