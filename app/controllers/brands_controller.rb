class BrandsController < ApplicationController
  # GET /brands
  # GET /brands.json
  def index
    @search = Brand.search(params[:search])
    @brands = @search.page(params[:page])
    puts "XXXX #{@brands.to_json}"
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/new
  # GET /brands/new.json
  def new
    @brand = Brand.new
    @sub_groups = []
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
    @sub_groups = SubGroup.where("group_id=?", @brand.group_id)
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: t(:data_created) }
      else
        @sub_groups = SubGroup.where("group_id=?", @brand.group_id)
        format.html { render action: "new" }
      end
    end
  end

  # PUT /brands/1
  # PUT /brands/1.json
  def update
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to @brand, notice: 'Marca fue actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.destroy
        format.html { redirect_to brands_url }
        format.json { head :no_content }
      else
        format.html { redirect_to brands_url, alert: @brand.errors.full_messages.join }
      end
    end
  end
end
