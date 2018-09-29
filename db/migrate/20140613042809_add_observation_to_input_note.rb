class AddObservationToInputNote < ActiveRecord::Migration
  def change
    add_column :input_notes, :observation, :text
    add_column :input_notes, :serial, :string
  end
end
