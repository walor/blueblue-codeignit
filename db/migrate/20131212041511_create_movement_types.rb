class CreateMovementTypes < ActiveRecord::Migration
  def change
    create_table :movement_types do |t|
      t.string :name
      t.integer :signal
      t.string :type_process
      t.timestamps
    end
  end
end
