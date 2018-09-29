class AddOrderGeneratedToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :order_generated, :boolean
  end
end
