class QuotationItem < ActiveRecord::Base
  belongs_to :quotation, inverse_of: :quotation_items
  belongs_to :product
  belongs_to :brand
  attr_accessible :cost_total, :cost_unit, :quantity, :product_id, :winner, :brand_id, :model, :detail
  validates :quantity, :product_id, presence: true
  after_update :total
end

def total
  if cost_unit
    self.update_column(:cost_total, cost_unit * quantity)
  end
end