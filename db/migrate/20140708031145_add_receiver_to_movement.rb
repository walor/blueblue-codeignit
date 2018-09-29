class AddReceiverToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :receiver, :string
  end
end
