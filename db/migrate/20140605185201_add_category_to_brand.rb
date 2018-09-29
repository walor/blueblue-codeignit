class AddCategoryToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :name, :string
    add_column :brands, :long_description, :string
    add_column :brands, :group_id, :integer, :references => :groups
    add_column :brands, :sub_group_id, :integer, :references => :sub_groups
  end
end
