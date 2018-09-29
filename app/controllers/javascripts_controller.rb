class JavascriptsController < ApplicationController

  def dynamic_groups_by_type
    render :json => Group.where("type_group=?", params[:type]).order('description')
  end

  def product_by_ware_house
    render :json => ProductWareHouse.where(product_id: params[:product_id], ware_house_id: params[:ware_house_id]).first
  end

  def dynamic_sub_groups_by_group_and_type
    render :json => SubGroup.where("group_id= ? and type_sub_group = ?", params[:group_id], params[:type])
  end

  def dynamic_sub_groups
    render :json => SubGroup.by_group(params[:group_id])
  end

  def dynamic_categories
    render :json => Category.by_sub_group(params[:sub_group_id])
  end

  def products_by_ware_house
    ware_house = WareHouse.find(params[:ware_house_id])
    render :json => ware_house.products
  end

  def dynamic_products
    render :json => Product.by_category(params[:category_id])
  end

  def dynamic_brands_by_group
    render :json => Brand.where("group_id = ?", params[:group_id])
  end

  def dynamic_brands_by_sub_group
    render :json => Brand.where("sub_group_id = ?", params[:sub_group_id])
  end


  # def get_product
  #   render :json => Product.find(params[:product_id])
  # end

  # def load_other_products_from_category
  #   render :json => Product.find(params[:product_id]).category.products
  # end

  # def load_other_categories_from_sub_group
  #   render :json => Category.find(params[:category_id]).sub_group.categories
  # end

  # def load_other_sub_groups_from_group
  #   render :json => SubGroup.find(params[:sub_group_id]).group.sub_groups
  # end

  # def load_other_brands_from_sub_group
  #   render :json => Brand.find(params[:brand_id]).sub_group.brands
  # end
end