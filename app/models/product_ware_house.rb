class ProductWareHouse < ActiveRecord::Base
  belongs_to :product
  belongs_to :ware_house
  attr_accessible :count_physical, :avg_price
end
