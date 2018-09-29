class AddProviderTypeToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :type_provider, :integer, :default => 1
  end
end
