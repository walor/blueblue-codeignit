class Product < ActiveRecord::Base
  include PreventDestroy::Model

  TYPE_PRODUCT = {
    1 => "Bienes",
    2 => "Servicios"
  }

	has_many :purchase_details
	has_many :quotation_items
	has_many :movement_items
	has_many :requeriment_items
	has_many :product_ware_houses

  belongs_to :measurement_unit
  belongs_to :group
  belongs_to :sub_group
  belongs_to :category

  attr_accessible :measurement_unit_id, :description, :name, :stock_max, :stock_min, :restock, :group_id, :sub_group_id, :category_id, :type_product, :desc_measurement_unit
  validates :description, :group_id, :sub_group_id, :category_id, :presence => true
  after_create :generate_name

  prevent_destroy_if_any :movement_items, :requeriment_items, :product_ware_houses
  scope :by_category, ->(category_id) {where("category_id= ?", category_id).order('description')}

  delegate :name, :to => :measurement_unit, :prefix => true

  private

  def generate_name
    new_name = category.products.pluck("max(name)").first || (category.name + "0000")
    self.update_column(:name, new_name.next)
  end
end