class ServRequerimentsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @requeriments.search(params[:search])
    @requeriments = @search.page(params[:page])
    @req = Requeriment.all
    respond_to do |format|
      format.html
    end
  end

end
