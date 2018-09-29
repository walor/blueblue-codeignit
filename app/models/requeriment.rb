class Requeriment < ActiveRecord::Base
  NORMAL    = 1
  PENDING   = 2
  PROCESS   = 3
  VALUED    = 4
  PARTIAL   = 5
  COMPLETED = 6
  CANCELED  = 7

  GOODS     = 1
  SERVICES  = 2

  STATUSES = {
    NORMAL    => 'borrador',
    PENDING   => 'pendiente',
    PROCESS   => 'cotizando',
    VALUED    => 'cotizado',
    PARTIAL   => 'cotizado parcial',
    COMPLETED => 'atendido',
    CANCELED  => 'anulado'
  }

  TYPE = {
    GOODS => 'Requerimiento de bienes',
    SERVICES => 'Requerimiento de servicios'
  }

  TYPE_ORDER = {
    GOODS => 'Orden de Compra',
    SERVICES => 'Orden de Servicio'
  }


  belongs_to :ware_house
  belongs_to :area
  belongs_to :responsible, class_name: 'User'
  has_many :requeriment_items, dependent: :destroy, inverse_of: :requeriment
  has_many :quotations, dependent: :destroy, inverse_of: :requeriment

  attr_accessible :reference, :description , :requeriment_items_attributes, :responsible_id, :ware_house_id,
                  :status_text, :deadline, :area_id, :status, :observation, :nam, :type_requeriment

  accepts_nested_attributes_for :requeriment_items, allow_destroy: true

  scope :completes, ->(){where(completed: true)}
  validates :deadline, :area_id,
            :responsible_id, presence: true

  validates_inclusion_of :status, :in => STATUSES.keys
  after_create :generate_name

  def type_text
    TYPE[self.type_requeriment]
  end

  def status_text
    STATUSES[self.status]
  end

  def status_text_order
    TYPE_ORDER[self.type_requeriment]
  end

  private

  def generate_name
    new_name = Requeriment.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

  def change_status
    if self.status != nil
      if self.status == NORMAL
        self.update_column(:status, PENDING)
      end
    end
  end
end