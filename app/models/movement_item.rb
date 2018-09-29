class MovementItem < ActiveRecord::Base
  belongs_to :movement, inverse_of: :movement_items
  belongs_to :product
  belongs_to :brand
  belongs_to :purchase_detail
  belongs_to :input_note_detail

  attr_accessible :price_total, :price_unit, :quantity, :product_id, :purchase_detail_id, :input_note_detail_id, :brand_id, :model, :detail, :created_at

  validates :price_total, :price_unit, :quantity, :product_id, presence: true

  # before_validation :set_price, unless: Proc.new{|i| i.price_unit.present?}
  before_validation :set_price_total

  after_create :update_current_stock, :update_purchase_detail_or_input_note
  # after_create :calculate_average_cost

  after_destroy :update_purchase_detail_delete

  private

  def update_current_stock
    product_ware_house = ProductWareHouse.find_or_initialize_by_product_id_and_ware_house_id(product_id, self.movement.ware_house_id)
    if movement.movement_type.present?
      if (movement.movement_type_id == 2 || movement.movement_type_id == 3) #si es orden de compra u salida de orden de compra update implicate
        product_ware_house.implicate += (quantity * movement.movement_type.signal)
      else
        product_ware_house.current_stock += (quantity * movement.movement_type.signal)
      end
      product_ware_house.avg_price = price_unit
      product_ware_house.save
    end
  end

  def regress_current_stock
    product_ware_house = ProductWareHouse.find_or_initialize_by_product_id_and_ware_house_id(product_id, self.movement.ware_house_id)
    if movement.movement_type.present?
      if (movement.movement_type_id == 2 || movement.movement_type_id == 3) #si es orden de compra u salida de orden de compra update implicate
        product_ware_house.implicate -= (quantity * movement.movement_type.signal)
      else
        product_ware_house.current_stock -= (quantity * movement.movement_type.signal)
      end
      product_ware_house.save
      product_ware_house.destroy if (product_ware_house.current_stock == 0 && product_ware_house.implicate == 0)
    end
  end

  def set_price_total
    if quantity.present? && price_unit.present?
      self.price_total = (quantity * price_unit)
    end
  end

  def set_product_data
    self.product_name = self.product.name if self.product_id.present?
  end

  def update_purchase_detail_or_input_note
    if movement.movement_type_id == 2 #si es compra hace el ingreso y se disminuye la cantidad y se mantiene parcialmente
      purchase_detail.update_attribute(:pending_quantity, purchase_detail.pending_quantity - quantity)
    elsif movement.movement_type_id == 3 #salida a oficinas
      purchase_detail.update_attribute(:outgoing, purchase_detail.outgoing + quantity)
    end
  end

  def calculate_average_cost
    total = 0
    MovementItem.joins(:movement).where(product_id: self.product_id).order(:date).each do |m|
      unless self.movement.movement_type.nil?
        total += (m.quantity * movement.movement_type.signal) * m.price_unit
      end
    end
    product_current_stock  = ProductWareHouse.where(product_id: self.product_id).sum(:current_stock)
    self.product.update_column(:avg_price, (total / product_current_stock).round(2)) if product_current_stock > 0
  end

  def update_purchase_detail_delete #al eliminar movimientos como se debe actualizar
    if movement.movement_type_id.present?
      if movement.movement_type_id == 2 || movement.movement_type_id == 3
        purchase_detail.update_attribute(:pending_quantity, purchase_detail.pending_quantity + quantity) if movement.movement_type_id == 2
        purchase_detail.update_attribute(:outgoing, purchase_detail.outgoing - quantity) if movement.movement_type_id == 3
        purchase_order = movement.purchase_order
        if purchase_order.without_outgoing? && purchase_order.without_incoming?
          purchase_order.update_attribute(:status, PurchaseOrder::SENT)
        else
          purchase_order.update_attribute(:status, PurchaseOrder::PARTIAL_CLOCKED)
        end
      end
      regress_current_stock
    end
  end
end