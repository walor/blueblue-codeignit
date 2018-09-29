class RequerimentsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @requeriments.order('id desc').search(params[:search])
    @requeriments = @search.page(params[:page])
    @req = Requeriment.all
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json{
        render json: @requeriment, include:  :requeriment_items
      }
      format.pdf{
        render pdf: "requerimiento_#{@requeriment.name}", wkhtmltopdf: '/usr/bin/wkhtmltopdf', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
        # render pdf: "requerimiento_#{@requeriment.name}", wkhtmltopdf: '/usr/local/bin/wkhtmltopdf', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
      }
    end
  end

  def new
    @requeriment.type_requeriment = Requeriment::GOODS
    # @requeriment.requeriment_items.build
    @groups = Group.where("type_group = ?", 1)#bienes por defecto
    respond_to do |format|
      format.html
    end
  end

  def edit
    @requeriment.requeriment_items
    @groups =  if @requeriment.type_requeriment == Requeriment::GOODS
      Group.where("type_group = ?", 1)#bienes por defecto
    else
      Group.where("type_group = ?", 2)
    end
  end

  def create
    if current_user.responsible_ware_house?
      @requeriment.ware_house_id = current_user.ware_house.id
      @requeriment.type_requeriment = Requeriment::GOODS
    end

    @requeriment.status = 1
    @requeriment.responsible_id = current_user.id

    respond_to do |format|
      if @requeriment.save
        format.html { redirect_to @requeriment, notice: t(:data_created) }
      else
        @groups = Group.where("type_group = ?", @requeriment.type_requeriment)
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @requeriment.update_attributes(params[:requeriment])
        format.html { redirect_to requeriment_path, notice: t(:data_updated) }
      else
        @groups = Group.where("type_group = ?", 1)#bienes por defecto
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    if Quotation.find_by_requeriment_id(@requeriment.id)

    else
      @requeriment.destroy
    end

    respond_to do |format|
      format.html { redirect_to requeriments_url }
    end
  end

  def toggle
    @requeriment.toggle! :completed
    respond_to do |format|
      format.html { redirect_to requeriments_url }
    end
  end

  def status_change
    if @requeriment.status == Requeriment::NORMAL
      @requeriment.update_column(:status, Requeriment::PENDING)

      respond_to do |format|
        format.html { redirect_to requeriments_url }
      end
    elsif @requeriment.status == Requeriment::PENDING
      @requeriment.update_column(:status, Requeriment::PROCESS)

      respond_to do |format|
        format.html { redirect_to quotations_url }
      end
    end
  end
end