class Movement < ActiveRecord::Base
  CANCELED = 1

  STATUS_TYPES = {
    CANCELED => "Anulado"
  }

  FACTURA     = 1
  BOLETA      = 2
  GUIA        = 3

  DOCUMENT_TYPES = {
    FACTURA => "Factura",
    BOLETA     => "Boleta",
    GUIA      => "Guia"
  }

  belongs_to :provider
  belongs_to :ware_house
  belongs_to :purchase_order
  belongs_to :input_note, dependent: :destroy
  belongs_to :movement_type
  belongs_to :emisor, class_name: 'User'
  # belongs_to :receiver, class_name: 'User'
  has_many :movement_items, dependent: :destroy, inverse_of: :movement

  attr_accessor :product_id
  accepts_nested_attributes_for :movement_items, allow_destroy: true
  attr_accessible :emisor_id, :ware_house_id, :movement_type_id, :provider_id, :status, :date, :movement_items_attributes, :receiver,
                 :invoice_date, :observation, :serial, :document_type, :purchase_order_id, :doc_ref, :invoice_number, :created_at
  # :price_unit, :quantity, :product_id,
  validates :emisor_id, :ware_house_id, :movement_type_id, presence: true
  #:quantity, :product_id,
  # before_create :set_price, if: Proc.new{|m| m.price_unit.nil?}
  after_create :generate_name
  before_destroy :check_dispatched_movements
  # after_create :update_current_stock
  # after_create :calculate_average_cost

  def generate_items_from_purchase_order
    purchase_order.purchase_details.each do |item|
      if item.pending_quantity > 0
        movement_items.build(
          :purchase_detail_id => item.id,
          :product_id => item.product_id,
          :quantity => item.pending_quantity,
          :price_unit => item.price_unit,
          :price_total => item.price_total,
          :brand_id => item.brand_id,
          :model => item.model,
          :detail => item.detail
        )
      end
    end
  end

  def generate_items_get_out
    purchase_order.purchase_details.each do |item|
      if item.pending_quantity < item.quantity#se ha entregado algo
        movement_items.build(
          :purchase_detail_id => item.id,
          :product_id => item.product_id,
          :quantity => (item.quantity - item.pending_quantity) - item.outgoing,
          :price_unit => item.price_unit,
          :price_total => item.price_total,
          :brand_id => item.brand_id,
          :model => item.model,
          :detail => item.detail
        )
      end
    end
  end

  def document_text
    DOCUMENT_TYPES[self.document_type]
  end

  def type_text
    TYPES[self.movement_type_id]
  end

  # def operation_type_name
  #   if input_note_id.present?
  #     input_note.movement_type.name
  #   else
  #     purchase_order.movement_type.name
  #   end
  # end

  def operation_number #numero de operacion de nota de entrada u orden de compra
    if purchase_order_id.present?
      purchase_order.name
    else
      name
    end
  end

  private

  def generate_name
    new_name = Movement.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

  def check_dispatched_movements
    if movement_type_id == 2
      if purchase_order.movements.pluck(:movement_type_id).uniq.include?(3)
        errors.add(:base, "No se puede eliminar porque la orden de compra tiene movimientos de salida")
      end
    end
    errors.blank?
  end
end