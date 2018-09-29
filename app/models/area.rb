class Area < ActiveRecord::Base
  include PreventDestroy::Model
  has_many :users
  has_many :ware_houses
  attr_accessible :active, :name, :code

  prevent_destroy_if_any :users, :ware_houses
end