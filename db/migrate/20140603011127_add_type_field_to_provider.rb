class AddTypeFieldToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :type, :integer, :default => 1
  end
end
