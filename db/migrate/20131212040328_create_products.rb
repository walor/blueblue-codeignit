class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :stock_min
      t.float :stock_max
      t.float :avg_price

      t.timestamps
    end
  end
end