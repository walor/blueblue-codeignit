class CreateSubGroups < ActiveRecord::Migration
  def change
    create_table :sub_groups do |t|
      t.integer :type_sub_group
      t.string :name
      t.string :description
      t.references :group
      t.timestamps
    end
  end
end
