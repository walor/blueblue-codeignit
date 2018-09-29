class AddColumnNameToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :status, :integer, null: false, default: 1, limit: 1
  end
end
