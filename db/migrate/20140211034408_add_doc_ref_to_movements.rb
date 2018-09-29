class AddDocRefToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :doc_ref, :string
  end
end
