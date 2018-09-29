class Group < ActiveRecord::Base
  #type_group:
  # 1: bienes
  # 2: servicios
  has_many :sub_groups, dependent: :destroy
  attr_accessible :name, :description, :type_group
  scope :by_type_group, ->(type_group) { where(type_group: type_group).order('description')}
end
