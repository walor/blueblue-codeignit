class AddRequerimentIdToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :requeriment_id, :integer
  end
end
