module MovementsHelper
  def can_destroy_movement?(movement)
    if movement.movement_type.id == 2
      (can? :destroy, movement) && movement.purchase_order.without_outgoing?
    else
      can? :destroy, movement
    end
  end
end