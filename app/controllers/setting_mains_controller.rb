class SettingMainsController < ApplicationController
  # GET /setting_mains/1
  # GET /setting_mains/1.json
  def show
    @setting_main = SettingMain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setting_main }
    end
  end

  # GET /setting_mains/new
  # GET /setting_mains/new.json
  def new
    @setting_main = SettingMain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @setting_main }
    end
  end

  # GET /setting_mains/1/edit
  def edit
    @setting_main = SettingMain.find(params[:id])
  end

  # POST /setting_mains
  # POST /setting_mains.json
  def create
    @setting_main = SettingMain.new(params[:setting_main])

    respond_to do |format|
      if @setting_main.save
        format.html { redirect_to @setting_main, notice: 'Setting main was successfully created.' }
        format.json { render json: @setting_main, status: :created, location: @setting_main }
      else
        format.html { render action: "new" }
        format.json { render json: @setting_main.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /setting_mains/1
  # PUT /setting_mains/1.json
  def update
    @setting_main = SettingMain.find(params[:id])

    respond_to do |format|
      if @setting_main.update_attributes(params[:setting_main])
        format.html { redirect_to @setting_main, notice: 'Setting main was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting_main.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setting_mains/1
  # DELETE /setting_mains/1.json
  def destroy
    @setting_main = SettingMain.find(params[:id])
    @setting_main.destroy

    respond_to do |format|
      format.html { redirect_to setting_mains_url }
      format.json { head :no_content }
    end
  end
end
