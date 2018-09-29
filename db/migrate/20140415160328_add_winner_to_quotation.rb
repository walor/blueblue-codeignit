class AddWinnerToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :winner, :boolean
  end
end
