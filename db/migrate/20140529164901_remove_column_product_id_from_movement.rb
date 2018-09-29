class RemoveColumnProductIdFromMovement < ActiveRecord::Migration
  def up
    remove_column :movements, :product_id
  end

  def down
    add_column :movements, :product_id, :integer
  end
end
