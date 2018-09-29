class CreateMeasurementUnits < ActiveRecord::Migration
  def change
    create_table :measurement_units do |t|
      t.string :name
      t.string :unit
      t.boolean :active

      t.timestamps
    end
  end
end