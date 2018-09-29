class WareHousesController < ApplicationController
  load_and_authorize_resource
  before_filter :load_responsibles, only: [:new, :create, :edit, :update, :own]

  def index
    @search = WareHouse.search(params[:search])
    @ware_houses = @search.page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def own
    @ware_houses = current_user.filter_ware_houses
    @operation_type = params[:operation_type] || 'initial'
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @ware_house.save
        format.html { redirect_to @ware_house, notice: t(:data_created) }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @ware_house.update_attributes(params[:ware_house])
        format.html { redirect_to @ware_house, notice: t(:data_updated) }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @ware_house.destroy
        format.html { redirect_to ware_houses_url }
      else
        format.html { redirect_to ware_houses_url, alert: @ware_house.errors.full_messages.join }
      end
    end
  end

  def kardex
    respond_to do |format|
      format.html{
        @ware_houses = WareHouse.all
        @products = []
      }
      format.js{
        @products = []
        if @ware_house
          if params[:product_id]
            @product = Product.find(params[:product_id])
            @movements = MovementItem.joins(:movement).where(product_id: @product, movements: {ware_house_id: @ware_house}).order(:date)
          else
            #ware_house = WareHouse.find(params[:ware_house][:id])
            @products = @ware_house.products
          end
        end
      }
    end
  end

  private

  def load_responsibles
    @responsibles = User.all
  end
end