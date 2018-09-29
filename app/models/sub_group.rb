class SubGroup < ActiveRecord::Base
  belongs_to :group
  has_many :categories, dependent: :destroy
  has_many :brands
  attr_accessible :name, :description, :type_sub_group, :group_id

  scope :by_group, ->(group_id) {where("group_id = ?", group_id).order('description')}
end