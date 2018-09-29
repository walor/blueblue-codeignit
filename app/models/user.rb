class User < ActiveRecord::Base
  include PreventDestroy::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :area
  has_one :ware_house, foreign_key: :responsible_id
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id, :area_id, :firstname, :lastname

  # attr_accessible :title, :body
  validates :firstname, :lastname, presence: true

  prevent_destroy_if_any :ware_house

  def name
  	lastname + ', ' + firstname
  end

  def super_admin?
  	role_id == 1
  end

  def administrator?
  	role_id == 2
  end

  def responsible_ware_house?
  	role_id == 3
  end

  def user?
  	role_id == 4
  end

  def filter_ware_houses
    list_ware_houses = []
    if responsible_ware_house? #aqui asume que tiene un almacen si tiene este rol
      list_ware_houses.append(ware_house)
    elsif administrator?
      list_ware_houses = area.ware_houses
    else
      list_ware_houses = WareHouse.all
    end
    list_ware_houses
  end

end