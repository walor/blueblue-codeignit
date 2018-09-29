class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :description
      t.text :observation
      t.timestamps
    end
  end
end
