class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @users.search(params[:search])
    @users = @search.page(params[:page])
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
      if @user.save
        format.html { redirect_to @user, notice: t(:data_created) }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: t(:data_updated) }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
end