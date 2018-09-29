class AddPositionToContactProvider < ActiveRecord::Migration
  def change
    add_column :providers, :position, :string
  end
end
