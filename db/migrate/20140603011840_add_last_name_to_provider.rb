class AddLastNameToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :fist_name, :string
    add_column :providers, :last_name, :string
    add_column :providers, :maiden_name, :string
    add_column :providers, :fax, :string
    add_column :providers, :email, :string
    add_column :providers, :web, :string
    add_column :providers, :cellphone, :string
    add_column :providers, :observations, :string
    add_column :providers, :type_company, :integer
    add_column :providers, :category_id, :integer, references: :categories
  end
end
