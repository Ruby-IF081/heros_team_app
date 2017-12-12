class PagesController < ApplicationController
  def index
    @pages = collection
  end

  def show
    @page = resource
  end

  private

  def resource
    Page.find(params[:id])
  end

  def collection
    Page.all
  end
end
