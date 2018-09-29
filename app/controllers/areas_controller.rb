class AreasController < ApplicationController
  load_and_authorize_resource

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area.active = true

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area fue creado correctamente.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area fue actualizado correctamente.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    respond_to do |format|
      if @area.destroy
        format.html { redirect_to areas_url }
      else
        format.html { redirect_to areas_url, alert: @area.errors.full_messages.join }
      end
    end
  end
end
