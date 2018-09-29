class QuotationsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @quotations.order('id desc').search(params[:search])
    @quotations = @search.page(params[:page]).per(15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json{
        render json: @quotation, include:  :quotation_items
      }
      format.pdf{
        render pdf: "cotizacion_#{@quotation.name}", wkhtmltopdf: '/usr/bin/wkhtmltopdf', page_size: 'A4', margin: {top: 0, bottom: 0, left: 0, right: 0}, lowquality: false
      }
    end
  end

  def new
    @requeriment_id = params[:requeriment_id]
    @requeriment = Requeriment.find (params[:requeriment_id])
    product_list = RequerimentItem.select("product_id, brand_id, model, detail, sum(quantity) as sum").group(:product_id, :brand_id, :model, :detail).joins(:requeriment).where(requeriments: {id: @requeriment_id, completed: false, status: 2})
      product_list.each do |product_requeriment|
      @quotation.quotation_items.build(product_id: product_requeriment.product_id, model: product_requeriment.model, detail: product_requeriment.detail, brand_id: product_requeriment.brand_id, quantity: product_requeriment.sum)
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    @quotation.status = Quotation::SENT
    respond_to do |format|
      if @quotation.save
        format.html { redirect_to @quotation, notice: 'Cotizacion fue creado correctamente.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    if PurchaseOrder.find_by_quotation_id(@quotation.id)

    else
      @quotation.destroy
    end

    respond_to do |format|
      format.html { redirect_to quotations_url }
    end
  end

  def fill_costs

    respond_to do |format|
      format.html
    end
  end

  def save_fill_costs
    if @quotation.status == Quotation::SENT
      @quotation.status = Quotation::CLOCKED
    end

    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to @quotation, notice: 'Cotizacion fue actualizado correctamente.' }
      else
        format.html { render action: "fill_costs" }
      end
    end
  end

  def toggle
    @quotation.toggle! :completed
    respond_to do |format|
      format.html { redirect_to quotations_url }
    end
  end

  def compare
    #@quotations = @quotations.select("requeriment_id, count(id) as count").group(:requeriment_id).where(:status => Requeriment::PROCESS)
    all_requeriments = Requeriment.where(:status => Requeriment::PROCESS, :area_id => @current_user.area_id).order('id desc')
    @requeriments = []
    all_requeriments.each do |requeriment|
      @requeriments.append({
                               'id' => requeriment.id,
                               'area_id' => requeriment.area.id,
                               'name' => requeriment.name,
                               'all_quotations' => Quotation.where(:requeriment_id => requeriment.id).count(:id),
                               'closed_quotations' => Quotation.where(:requeriment_id => requeriment.id, :status => 3).count(:id),
                               'model' => requeriment,
                           })
    end


    if params[:compare_requeriment_id].present?
      @active = true
      for requeriment_item in RequerimentItem.where(:requeriment_id => params[:compare_requeriment_id]) do
        if params[:"quotation_details_#{requeriment_item.product.id.to_s}_id"].present?
          @quotation_item = QuotationItem.update(params[:"quotation_details_#{requeriment_item.product.id.to_s}_id"], :winner => true)
          Quotation.update(@quotation_item.quotation_id, :winner => true)
        elsif
          @active = false
        end
      end

      if @active
        Requeriment.update(params[:compare_requeriment_id], :status => Requeriment::VALUED)
      else
        Requeriment.update(params[:compare_requeriment_id], :status => Requeriment::PARTIAL)
      end

      respond_to do |format|
        format.html { redirect_to quotations_url }
      end

    elsif params[:requeriment_id].present?
      @requeriment = Requeriment.find params[:requeriment_id]
      @quotations_compare = @requeriment.quotations.includes(:provider, :quotation_items => :product).where(status: Requeriment::PROCESS)
      @products = @quotations_compare.map(&:quotation_items).flatten.map(&:product).flatten.uniq
      respond_to do |format|
        format.html
      end
    end

  end

  def pending_requeriment
    all_requeriments = Requeriment.where(:status => Requeriment::PENDING)
    @requeriments = []
    all_requeriments.each do |requeriment|

      @requeriments.append({
                               'id' => requeriment.id,
                               'area_id' => requeriment.area.id,
                               'name' => requeriment.name,
                               'all_quotations' => Quotation.where(:requeriment_id => requeriment.id).count(:id),
                               'closed_quotations' => Quotation.where(:requeriment_id => requeriment.id, :status => 3).count(:id),
                           })
    end
    #requeriments.each do |requeriment|
    #  @quotation.quotation_items.build(product_id: requeriment.id, quantity: requeriments.name)
    #end
    respond_to do |format|
      format.html
    end
  end
end