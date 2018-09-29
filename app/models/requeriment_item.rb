class RequerimentItem < ActiveRecord::Base
  belongs_to :requeriment, inverse_of: :requeriment_items
  belongs_to :product
  belongs_to :brand
  attr_accessor :category_id, :sub_group_id, :group_id
  attr_accessible :quantity, :group_id, :sub_group_id, :category_id, :product_id, :winner, :brand_id, :color, :size, :model, :detail
  validates :quantity, :product_id, presence: true

  def group_id
    product.group_id unless product.nil?
  end

  def sub_group_id
    product.sub_group_id unless product.nil?
  end

  def category_id
    product.category_id unless product.nil?
  end
end