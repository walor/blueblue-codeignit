class AddFieldsToPrdocut2 < ActiveRecord::Migration
  def change
    add_column :products, :group_id, :integer, :references => :groups
    add_column :products, :sub_group_id, :integer, :references => :sub_groups
    add_column :products, :type_product, :integer
    add_column :products, :desc_measurement_unit, :string
  end
end