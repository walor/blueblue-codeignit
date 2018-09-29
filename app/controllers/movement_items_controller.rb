class MovementItemsController < ApplicationController
  def index #kardex
    @ware_houses = current_user.filter_ware_houses
    if params[:search] && params[:search][:movement_ware_house_id_eq] && params[:search][:movement_ware_house_id_eq].blank?
      params[:search][:movement_ware_house_id_in] = @ware_houses.map(&:id)
    end
    @search = if params[:search].nil?
      MovementItem.includes(:movement).where('movements.ware_house_id in (?)', @ware_houses.map(&:id)).search(params[:search])
    else
      MovementItem.includes(:movement).search(params[:search])
    end
    movements = @search
    @products = []
    @movement_items = []
    @movement_items = movements.order('movement_items.created_at asc').group_by(&:product_id)
    unless params[:search].nil?
      if params[:search][:movement_ware_house_id_eq].present?
        ware_house = WareHouse.find(params[:search][:movement_ware_house_id_eq])
        @products = ware_house.products
      end
    end
  end

  def update
    @movement_item = MovementItem.find params[:id]
    respond_to do |format|
      if @movement_item.update_attributes(params[:movement_item])
        format.js {render :js => 'alert("Se actualizo correctamente")'}
      else
        format.js { render :js => 'alert("No se pudo actualizar")' }
      end
    end
  end
end