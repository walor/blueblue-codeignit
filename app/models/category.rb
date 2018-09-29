class Category < ActiveRecord::Base
  belongs_to :sub_group
  has_many :products, dependent: :destroy
  attr_accessible :description, :name, :type_category, :sub_group_id
  scope :by_sub_group, ->(sub_group_id) {where("sub_group_id= ?", sub_group_id).order('description')}
end