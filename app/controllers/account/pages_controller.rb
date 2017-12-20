class Account::PagesController < ApplicationController
  def index
    @pages = collection.page(params[:page]).per(10)
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
