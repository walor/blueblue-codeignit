class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :type_group
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
