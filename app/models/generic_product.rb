class GenericProduct < ActiveRecord::Base
  belongs_to :category
  attr_accessible :name, :category_id, :description, :measurement_unit, :generic_product_type
end
