class PurchaseDetail < ActiveRecord::Base
  belongs_to :purchase_order, inverse_of: :purchase_details
  belongs_to :product
  belongs_to :brand

  attr_accessible :price_total, :price_unit, :product_id, :product_description, :product_name, :quantity, :incoming, :outgoing, :model, :brand_id, :detail
  validates :price_total, :price_unit, :product_id, :product_description, :product_name, :quantity, presence: true
  before_validation :set_total, :set_product_data, :set_pending_quantity
  after_update :update_purchase_order

  private

  def update_purchase_order
    details = purchase_order.purchase_details

    total_pending_quantity = details.pluck(:pending_quantity).reduce(:+).to_i
    total_outgoing = details.pluck(:outgoing).reduce(:+).to_i
    total_quantity = details.pluck(:quantity).reduce(:+).to_i

    if pending_quantity_changed?
      if total_pending_quantity == 0
        purchase_order.update_column(:status, PurchaseOrder::CLOCKED)
      else
        purchase_order.update_column(:status, PurchaseOrder::PARTIAL_CLOCKED)
      end
    elsif incoming_changed?
      if total_outgoing == total_quantity
        purchase_order.update_column(:status, PurchaseOrder::EXIT)
      elsif total_outgoing < total_quantity
        if total_pending_quantity == 0
          purchase_order.update_column(:status, PurchaseOrder::CLOCKED)
        else
          purchase_order.update_column(:status, PurchaseOrder::PARTIAL_CLOCKED)
        end
      end
    end
  end

  def set_pending_quantity
    self.pending_quantity = self.quantity
    self.outgoing = 0
  end

  def set_total
  	self.price_total = quantity * price_unit
  end

  def set_product_data
  	if self.product_id.present?
  		self.product_name = self.product.name
  		self.product_description = self.product.description
  	end
  end
end