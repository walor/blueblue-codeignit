class AddFirstNameToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :first_name, :string
  end
end
