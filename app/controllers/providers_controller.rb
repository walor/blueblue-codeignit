class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Provider.search(params[:search])
    @providers = @search.page(params[:page])
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
    @provider = Provider.new type_provider: Provider::COMPANY
    @provider = Provider.new type_company: Provider::NATIONAL
    @sub_groups = []
    @categories = []

    respond_to do |format|
      format.html
    end
  end

  def edit
    @sub_groups = SubGroup.where("group_id=?", @provider.group_id)
    @categories = Category.where("sub_group_id=?", @provider.sub_group_id)
  end

  def create
    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: t(:data_created) }
      else
        @sub_groups = SubGroup.where("group_id=?", @provider.group_id)
        @categories = Category.where("sub_group_id=?", @provider.sub_group_id)
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to @provider, notice: t(:data_updated) }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @provider.destroy
        format.html { redirect_to providers_url }
      else
        format.html { redirect_to providers_url, alert: @provider.errors.full_messages.join }
      end
    end
  end
end
