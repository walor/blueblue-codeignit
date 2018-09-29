class CreateRequeriments < ActiveRecord::Migration
  def change
    create_table :requeriments do |t|
      t.string :name
      t.references :ware_house
      t.integer :responsible_id
      t.boolean :completed, default: false

      t.timestamps
    end
    add_index :requeriments, :ware_house_id
  end
end
