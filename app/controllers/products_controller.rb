class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Product.order('created_at desc').search(params[:search])
    if params[:category_id].nil?
      @products = @search.page(params[:page])
    else
      @products = @search.page(params[:page])
    end

    @groups = Group.all
    @sub_groups = []
    @categories = []

    unless params[:search].nil?
      @sub_groups = SubGroup.where("group_id=?", params[:search][:group_id_eq]) if params[:search][:group_id_eq]
      @categories = Category.where("sub_group_id=?", params[:search][:sub_group_id_eq]) if params[:search][:group_id_eq]
    end

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
    @sub_groups = []
    @categories = []
    respond_to do |format|
      format.html
    end
  end

  def edit
    @sub_groups = SubGroup.where("group_id=?", @product.group_id)
    @categories = Category.where("sub_group_id=?", @product.sub_group_id)
  end

  def create
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t(:data_created) }
      else
        @sub_groups = SubGroup.where("group_id=?", @product.group_id)
        @categories = Category.where("sub_group_id=?", @product.sub_group_id)
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: t(:data_updated) }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_url }
      else
        format.html { redirect_to products_url, alert: @product.errors.full_messages.join }
      end
    end
  end
end