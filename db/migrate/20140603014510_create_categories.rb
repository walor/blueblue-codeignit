class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :type_category
      t.string :name
      t.string :description
      t.references :sub_group
      t.timestamps
    end
  end
end
