class PurchaseOrder < ActiveRecord::Base
  NORMAL          = 1
  SENT            = 2
  PARTIAL_CLOCKED = 3
  CLOCKED         = 4
  EXIT            = 5
  CANCELED        = 6

  STATUSES = {
    NORMAL          => 'Borrador',
    SENT            => 'Pendiente',
    PARTIAL_CLOCKED => 'parcialmente',
    CLOCKED         => 'Salida',
    EXIT            => 'Enviada',#SALIDA
    CANCELED        => 'Anulado'
  }

  belongs_to :provider
  belongs_to :quotation
  has_many :movements
  has_many :purchase_details, dependent: :destroy, inverse_of: :purchase_order

  accepts_nested_attributes_for :purchase_details, allow_destroy: true
  attr_accessor :doc_ref
  attr_accessible :provider_id, :date, :sub_total, :total, :purchase_details_attributes, :doc_ref, :observations, :validity, :delivery, :pay_form, :quotation_id, :status

  validates :provider_id, presence: true
  validates_inclusion_of :status, :in => STATUSES.keys

  after_validation :set_totals
  after_create :generate_name
  before_validation :add_items_from_quotation

  def self.pending_incoming_purchases
    statuses = [PurchaseOrder::PARTIAL_CLOCKED, PurchaseOrder::CLOCKED]
    purchase_orders = where("type_order= ?", 1).where(:status => statuses).joins(:purchase_details).group("purchase_orders.id").
      having("sum(quantity) > sum(pending_quantity) and sum(quantity) - sum(pending_quantity) - sum(outgoing) > 0")
  end

  def status_text
    STATUSES[self.status]
  end

  def cancel
    update_column(:status, PurchaseOrder::CANCELED)
  end

  def without_outgoing?
    purchase_details.map(&:outgoing).sum == 0
  end

  def without_incoming?
    purchase_details.map(&:quantity).sum == purchase_details.map(&:pending_quantity).sum
  end

  private
  def generate_name
  	new_name = PurchaseOrder.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

  def set_totals
  	self.total = self.purchase_details.map(&:price_total).reduce(:+).to_f
  	self.sub_total = self.total
  end

  def add_items_from_quotation
    quotation.quotation_items.each do |quotation_item|
      if quotation_item.winner
        purchase_details.build(
          :product_id => quotation_item.product_id,
          :quantity => quotation_item.quantity,
          :price_unit => quotation_item.cost_unit,
          :price_total => quotation_item.cost_total,
          :brand_id => quotation_item.brand_id,
          :detail => quotation_item.detail,
          :model => quotation_item.model
        )
      end
    end
  end
end