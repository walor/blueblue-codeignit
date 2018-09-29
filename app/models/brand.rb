class Brand < ActiveRecord::Base
  include PreventDestroy::Model

  has_many :products

  attr_accessible :name, :description, :long_description, :observation, :group_id, :sub_group_id
  after_create :generate_name

  validates :description, presence: true

  prevent_destroy_if_any :products

  private

  def generate_name
    new_name = Brand.maximum(:name) || '00000000'
    self.update_column(:name, new_name.next)
  end

end