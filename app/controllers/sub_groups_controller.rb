class SubGroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @search = SubGroup.search(params[:search])
    @sub_groups = @search.page(params[:page]).per(15)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @sub_group = SubGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @sub_group = SubGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_group }
    end
  end

  # GET /groups/1/edit
  def edit
    @sub_group = SubGroup.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @sub_group = SubGroup.new(params[:sub_group])

    respond_to do |format|
      if @sub_group.save
        format.html { redirect_to @sub_group, notice: 'Group was successfully created.' }
        format.json { render json: @sub_group, status: :created, location: @sub_group }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @sub_group = SubGroup.find(params[:id])

    respond_to do |format|
      if @sub_group.update_attributes(params[:group])
        format.html { redirect_to @sub_group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @sub_group = SubGroup.find(params[:id])
    @sub_group.destroy

    respond_to do |format|
      format.html { redirect_to sub_groups_url }
      format.json { head :no_content }
    end
  end
end
