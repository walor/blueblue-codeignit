class Provider < ActiveRecord::Base

  include PreventDestroy::Model

  COMPANY = 1
  PERSON  = 2

  TYPES_PROVIDER = {
    COMPANY => "Empresa",
    PERSON  => "Persona natural"
  }

  NATIONAL  = 1
  FOREIGN   = 2

  TYPES_COMPANY = {
    NATIONAL  => "Nacional",
    FOREIGN   => "Extranjera"
  }

  belongs_to :category
  belongs_to :sub_group
  belongs_to :group
  has_one :agent
	has_many :quotations
	has_many :purchase_orders
  attr_accessible :address, :name, :phone, :resposible, :ruc, :type_provider, :type_company, :first_name, :last_name, :maiden_name, :position, :cellphone, :fax, :email, :web, :group_id, :sub_group_id, :category_id
  validates :address, :name, :phone, :resposible, :ruc, presence: true

  prevent_destroy_if_any :quotations, :purchase_orders

  def type_text
    TYPES_PROVIDER[self.type_provider]
  end

  def type_company_text
    TYPES_COMPANY[self.type_company]
  end
end