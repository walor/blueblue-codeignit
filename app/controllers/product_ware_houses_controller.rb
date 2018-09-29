class ProductWareHousesController < ApplicationController
  # load_and_authorize_resource

  def index
    @compare = false
    @ware_house = WareHouse.find params[:ware_house_id]
    @product_ware_houses = @ware_house.product_ware_houses
    respond_to do |format|
      format.html
    end
  end

  def update_multiple
    @product_ware_houses = ProductWareHouse.update(params[:product_ware_houses].keys, params[:product_ware_houses].values)
    @compare = true
    @ware_house = @product_ware_houses.first.ware_house
    render "index"
  end
end