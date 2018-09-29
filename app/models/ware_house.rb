class WareHouse < ActiveRecord::Base
  include PreventDestroy::Model

	has_many :movements
	has_many :movement_items
  has_many :requeriments
	has_many :product_ware_houses
	has_many :products, through: :product_ware_houses, uniq: true
  attr_accessible :name, :responsible_id, :description, :address, :telephone, :cost_center, :area_id, :initial, :close
  belongs_to :responsible, class_name: 'User'
  belongs_to :area
  validates :name, :responsible_id, :area_id, presence: true

  prevent_destroy_if_any :movements, :products, :requeriments

end