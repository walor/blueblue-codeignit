class RemoveFistNameFromProvider < ActiveRecord::Migration
  def up
    remove_column :providers, :fist_name
  end

  def down
    add_column :providers, :fist_name, :string
  end
end
