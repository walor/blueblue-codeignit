class Ability
  include CanCan::Ability

  def initialize(user)
    if user
        if user.super_admin?
            can :manage, :all
        end
        if user.administrator?
            can :manage, WareHouse
            can :manage, Product
            can :manage, Group
            can :manage, SubGroup
            can :manage, Category
            can :manage, Brand
            can :manage, Provider
            can :manage, Movement
            can :manage, SettingMain
            #can :print, Movement
            #can :destroy, Movement, movement_type_id: 1
            #can :new_purchase, Movement, movement_type_id: 1
            #can :create_purchase, Movement, movement_type_id: 1
            can :manage, Requeriment
            can :manage, Quotation
            can :manage, PurchaseOrder
            can :manage, User
            can :manage, Area
        end
        if user.responsible_ware_house?
            can [:index, :own], WareHouse, id: user.ware_house.id
            can :read, Movement, ware_house_id: user.ware_house.id
            can :print, Movement, ware_house_id: user.ware_house.id
            can :destroy, Movement, ware_house_id: user.ware_house.id, movement_type_id: [2, 3]
            can :new_incoming, Movement, ware_house_id: user.ware_house.id, movement_type_id: 2
            can :create_incoming, Movement, ware_house_id: user.ware_house.id, movement_type_id: 2
            can :new_get_out, Movement, ware_house_id: user.ware_house.id, movement_type_id: 4
            can :create_get_out, Movement, ware_house_id: user.ware_house.id, movement_type_id: 4
            can :new_purchase, Movement, ware_house_id: user.ware_house.id, movement_type_id: 1
            can :create_purchase, Movement, ware_house_id: user.ware_house.id, movement_type_id: 1
            can :new_get_out_purchase_order, Movement, ware_house_id: user.ware_house.id, movement_type_id: 3
            can :create_get_out_purchase_order, Movement, ware_house_id: user.ware_house.id, movement_type_id: 3
            can :pending_incoming_purchases, Movement
            can :purchase_orders, Movement
            can [:add_product, :initial], Movement
            can :manage, Brand
            can :manage, Requeriment, responsible_id: user.id
        end
    end
  end
end