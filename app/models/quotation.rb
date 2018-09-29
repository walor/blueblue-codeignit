class Quotation < ActiveRecord::Base
  NORMAL    = 1
  SENT      = 2
  CLOCKED   = 3
  GENERATE  = 4
  COMPLETED  = 5
  CANCELED  = 6

  STATUSES = {
      NORMAL    => 'borrador',
      SENT      => 'enviado',
      CLOCKED   => 'cerrado',
      GENERATE  => 'OC generada',
      COMPLETED  => 'Completada',
      CANCELED  => 'OC Anulado'
  }

  belongs_to :provider
  belongs_to :requeriment
  has_many :quotation_items, dependent: :destroy, inverse_of: :quotation
  accepts_nested_attributes_for :quotation_items, allow_destroy: true
  attr_accessible :provider_id, :completed, :quotation_items_attributes, :observations, :validity, :delivery, :pay_form, :requeriment_id, :winner
  scope :completes, ->(){where(winner: true)}
  validates :provider_id, presence: true
  validates_inclusion_of :status, :in => STATUSES.keys
  after_create :generate_name
  after_update :change_status

  def status_text
    STATUSES[self.status]
  end

  private

  def generate_name
    new_name = Quotation.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

  private
  def change_status
    if status == NORMAL
      self.update_column(:status, SENT)
    end
  end
end
