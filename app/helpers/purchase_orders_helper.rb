module PurchaseOrdersHelper
  def can_cancel?(purchase_order)
    current_user.administrator? && (purchase_order.status == PurchaseOrder::NORMAL || purchase_order.status == PurchaseOrder::SENT)
  end

  def can_destroy?(purchase_order)
    current_user.super_admin? && (purchase_order.status == PurchaseOrder::NORMAL || purchase_order.status == PurchaseOrder::SENT)
  end
end