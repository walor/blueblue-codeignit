class RemoveTypeFromProvide < ActiveRecord::Migration
 
  def up
    remove_column :providers, :type
  end

  def down
    add_column :providers, :type, :integer, :default => 1
  end
end
