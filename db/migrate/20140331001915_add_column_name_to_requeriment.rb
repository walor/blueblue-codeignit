class AddColumnNameToRequeriment < ActiveRecord::Migration
  def change
    add_column :requeriments, :description, :string
    add_column :requeriments, :reference, :string
    add_column :requeriments, :status, :integer, null: false, default: 1, limit: 1
    add_column :requeriments, :area_id, :integer
    add_column :requeriments, :deadline, :date
  end
end