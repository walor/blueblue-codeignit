class AddIndexNameToCategory < ActiveRecord::Migration
  def change
    add_index :categories, [:name, :type_category], :unique => true
  end
end
