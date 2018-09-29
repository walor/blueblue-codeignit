class PurchaseOrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = PurchaseOrder.order('id desc').search(params[:search])
    @purchase_orders = @search.page(params[:page]).per(15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json{
        render json: @purchase_order, include:  :purchase_details
      }
      format.pdf{
        # render pdf: "orden_de_compra_#{@purchase_order.name}", wkhtmltopdf: '/usr/local/bin/wkhtmltopdf', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
        render pdf: "orden_de_compra_#{@purchase_order.name}", wkhtmltopdf: '/usr/bin/wkhtmltopdf', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
      }
    end
  end

  def new
    @quotation_id = params[:quotation_id]
    @quotation = Quotation.find(@quotation_id)

    # @quotations = Quotation.includes(:provider).all#, :quotation_items => :product).all
    # @products = Product.joins(:quotation_items).where(quotation_items: {quotation_id: @quotations}).uniq
    #@doc_refs = Quotation.completes.map{|r| ["Cotizacion #{r.name}", "q_#{r.id}"]}

    # @purchase_order.purchase_details.build

    # @products.each do |product|
    #   @quotations.each do |quotation|
    #     @purchase_order.purchase_details.build(product_id: product.id, price_unit: (quotation.quotation_items.find_by_product_id(product.id).try(:cost_unit) || 0))
    #   end
    # end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @quotations = Quotation.includes(:provider).all#, :quotation_items => :product).all
    # @products = Product.joins(:quotation_items).where(quotation_items: {quotation_id: @quotations}).uniq
  end

  def create
    @quotation = @purchase_order.quotation
    @quotation.order_generated = true
    @quotation.status = Quotation::GENERATE
    @quotation.save

    @purchase_order.provider_id = @quotation.provider_id
    @purchase_order.status = PurchaseOrder::SENT
    @purchase_order.delivery = @quotation.delivery
    @purchase_order.validity = @quotation.validity
    @purchase_order.observations = @quotation.observations
    @purchase_order.pay_form = @quotation.pay_form
    @purchase_order.type_order = @quotation.requeriment.type_requeriment

    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: 'Orden de compra fue creado correctamente.' }
      else
        # @quotations = Quotation.includes(:provider).all#, :quotation_items => :product).all
        # @products = Product.joins(:quotation_items).where(quotation_items: {quotation_id: @quotations}).uniq
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase_order.update_attributes(params[:purchase_order])
        format.html { redirect_to @purchase_order, notice: 'Orden de compra fue actualizado correctamente.' }
      else
        # @quotations = Quotation.includes(:provider).all#, :quotation_items => :product).all
        # @products = Product.joins(:quotation_items).where(quotation_items: {quotation_id: @quotations}).uniq
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url }
    end
  end

  def canceled
    @purchase_order.cancel
    quotation = @purchase_order.quotation
    quotation.status = Quotation::CANCELED
    quotation.save
    respond_to do |format|
      format.html { redirect_to purchase_orders_url }
    end
  end

  def quotation_list
    @quotations = Quotation.where(:winner => true, :status => Quotation::CLOCKED).order('id desc')
    respond_to do |format|
      format.html
    end
  end
end