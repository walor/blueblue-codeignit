class AddGroupAndSubGroupToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :group_id, :integer, :references => :groups
    add_column :providers, :sub_group_id, :integer, :references => :sub_groups
  end
end
