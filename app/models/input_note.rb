class InputNote < ActiveRecord::Base
  #invoice_number like number_document

  ENTRY_INITIAL  = 1
  PENDING       = 2
  DISPATCHED    = 3

  STATUSES = {
    ENTRY_INITIAL  => 'Inicial',
    PENDING     => 'Pendiente',
    DISPATCHED  => 'Enviada' #SALIDA
  }


  FACTURA     = 1
  BOLETA      = 2
  GUIA        = 3

  DOCUMENT_TYPES = {
    FACTURA => "Factura",
    BOLETA     => "Boleta",
    GUIA      => "Guia"
  }

  # attr_accessible :title, :body
  has_one :movement
  has_many :input_note_details
  belongs_to :emisor, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :provider
  belongs_to :ware_house
  belongs_to :movement_type
  belongs_to :area_origin, foreign_key: :area_origin_id, class_name: 'Area'
  belongs_to :area_destination, foreign_key: :area_destination_id, class_name: 'Area'
  after_validation :set_totals
  after_create :generate_name


  accepts_nested_attributes_for :movement, :input_note_details, allow_destroy: true
  attr_accessible :emisor_id, :receiver_id, :provider_id, :date, :sub_total, :total, :movement_attributes, :input_note_details_attributes, :status, :area_origin_id, :area_destination_id,
                  :ware_house_id, :observation, :serial, :document_type, :movement_type_id, :destination, :type_input_note, :model, :brand_id, :detail, :doc_ref, :created_at

  validates :emisor_id, :ware_house_id, :movement_type_id, presence: true
  # validates :provider_id, presence: true

  def new_movement
    movement = build_movement
    # movement.movement_type_id = Movement::INCOMING_INPUT_NOTE
    movement.movement_type_id = self.movement_type_id
    movement.emisor_id = self.emisor_id
    movement.provider_id = self.provider_id
    movement.ware_house_id = self.ware_house_id
    movement.doc_ref = self.doc_ref
    movement.date = self.created_at #fecha de creacion
    movement.observation = self.observation
    movement.serial = self.serial
    movement.document_type = self.document_type
    input_note_details.each do |item|
      movement.movement_items.build(
        :product_id => item.product_id,
        :quantity => item.quantity - item.outgoing,
        :price_unit => item.price_unit,
        :price_total => item.price_total,
        :brand_id => item.brand_id,
        :model => item.model,
        :detail => item.detail,
        :input_note_detail_id => item.id
      )
    end
    movement
  end

  def document_text
    DOCUMENT_TYPES[document_type] unless document_type.nil?
  end


  def self.pending_input_notes
    input_notes = where("status = ?", PENDING)
  end

  def generate_name
  	new_name = InputNote.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

  def set_totals
  	self.total = input_note_details.map(&:price_total).reduce(:+).to_f
  	self.sub_total = total
  end
end