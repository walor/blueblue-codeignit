class MovementsController < ApplicationController
  load_and_authorize_resource

  def index
    @ware_house_ids = current_user.filter_ware_houses.map(&:id)
    @search = if current_user.super_admin?
      @movements.includes(:movement_type, :ware_house).order('id DESC').search(params[:search])
    else current_user.responsible_ware_house?
      @movements.includes(:movement_type, :ware_house).where('ware_house_id in (?)', @ware_house_ids).order('id DESC').search(params[:search])
    end
    @movements.includes(:movement_type, :ware_house).where(ware_house_id: current_user.area.ware_houses.pluck(:id)).order('id DESC').search(params[:search])
    @movements = @search.page(params[:page]).per(15)
    @movement = Movement.new
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def print
    respond_to do |format|
      format.pdf{
        render pdf: "file_name", wkhtmltopdf: '/usr/bin/wkhtmltopdf', orientation: 'landscape', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
      }
    end
  end

  def new_purchase
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    @movement = @purchase_order.movements.new(ware_house_id: @purchase_order.quotation.requeriment.ware_house.id)
    @movement.generate_items_from_purchase_order
    respond_to do |format|
      format.html
    end
  end

  def purchase_orders
    statuses = [PurchaseOrder::SENT, PurchaseOrder::PARTIAL_CLOCKED]
    @search = PurchaseOrder.where("type_order= ?", 1).where(:status => statuses).order('id desc').search(params[:search])
    @purchase_orders = @search.page(params[:page]).per(15)
    respond_to do |format|
      format.html
    end
  end

  def pending_incoming_purchases
    @search = PurchaseOrder.pending_incoming_purchases.order('id desc').search(params[:search])
    @purchase_orders = @search.page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def create_purchase
    purchase_order = PurchaseOrder.find(params[:movement][:purchase_order_id])
    attributes = purchase_order.attributes.slice("provider_id").merge(params[:movement])
    @movement = Movement.new(attributes)
    @movement.receiver_id = @movement.ware_house.responsible_id if @movement.ware_house_id
    @movement.emisor_id = current_user.id
    @purchase_orders = PurchaseOrder.all
    respond_to do |format|
      if @movement.save
        format.html { redirect_to @movement, notice: t(:data_created) }
      else
        format.html { render action: "new_purchase" }
      end
    end
  end

  def new_incoming
    # @groups = Group.where("type_group = ?", 1).order('description')#bienes por defecto
    @input_note = InputNote.new
    @input_note.input_note_details.build
    @input_note.type_input_note = 1
    respond_to do |format|
      format.html
    end
  end

  def initial
    @ware_house = WareHouse.find(params[:ware_house_id])
    @search =  @ware_house.movements.where(movement_type_id: 1).includes(:movement_type).order('id DESC').search(params[:search])
    @movements = @search.page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def create_incoming
    @input_note = InputNote.new(params[:input_note])
    @input_note.emisor_id = current_user.id
    respond_to do |format|
      if @input_note.save
        @movement = @input_note.new_movement
        @movement.save
        if @input_note.movement_type_id == 1 #si es saldo incial forzar a que sea el primer movimiento
          @input_note.update_attributes(created_at: Date.today.beginning_of_year)
          @movement.update_attributes(created_at: Date.today.beginning_of_year)
          @movement.movement_items.update_all(created_at: Date.today.beginning_of_year)
        end
        format.html { redirect_to @movement, notice: t(:data_created) }
      else
        format.html { render action: "new_incoming" }
      end
    end
  end

  def new_get_out
    @ware_house = WareHouse.find params[:ware_house_id]
    @products = @ware_house.products
    @movement = Movement.new(ware_house_id: @ware_house.id)
    respond_to do |format|
      format.html
    end
  end

  def new_get_out_purchase_order
    purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    @movement = Movement.new :purchase_order_id => purchase_order.id, :ware_house_id => purchase_order.quotation.requeriment.ware_house.id
    @movement.generate_items_get_out

    respond_to do |format|
      format.html
    end
  end

  def create_get_out
    purchase_order = PurchaseOrder.find(params[:movement][:purchase_order_id])
    attributes = purchase_order.attributes.slice("provider_id").merge(params[:movement])
    @movement = Movement.new(attributes)
    @movement.emisor_id = current_user.id
    respond_to do |format|
      if @movement.save
        format.html { redirect_to @movement, notice: t(:data_created) }
      else
        @products = @movement.ware_house.products
        format.html { redirect_to ware_house_new_get_out_path(@movement.ware_house.id), alert: "Elija el tipo de movimiento" }
      end
    end
  end

  def create_get_out_purchase_order
    @movement = Movement.new(params[:movement])
    @movement.receiver_id = @movement.ware_house.responsible_id if @movement.ware_house_id
    @movement.emisor_id = current_user.id
    @purchase_orders = PurchaseOrder.all
    respond_to do |format|
      if @movement.save
        format.html { redirect_to @movement, notice: t(:data_created) }
      else
        format.html { render action: "new_get_out_purchase_order" }
      end
    end
  end

  def destroy
    message = @movement.errors[:base].first unless @movement.destroy
    respond_to do |format|
      format.html { redirect_to movements_url, :notice => message }
    end
  end

  def pending_input_notes
    @search = InputNote.pending_input_notes.order('id desc').search(params[:search])
    @input_notes = @search.page(params[:page]).per(15)
  end
end