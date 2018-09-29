class AddColumnNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :area_id, :integer, null: true, default: 1
  end
end
