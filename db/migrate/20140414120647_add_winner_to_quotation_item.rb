class AddWinnerToQuotationItem < ActiveRecord::Migration
  def change
    add_column :quotation_items, :winner, :boolean
  end
end
