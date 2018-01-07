class Account::ChromeExtensionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @page = Page.new(source_url: params[:source_url], title: params[:title])
  end

  def create
    @company = current_user.companies.find_by(id: params[:page][:company_id])
    @page = Page.new_by_company(params_without_company_id, @company)
    if @page.save
      flash[:success] = 'Page successfully added'
      redirect_to [:account, @company, :pages]
    else
      render :new
    end
  end

  private

  def params_without_company_id
    params.require(:page).permit(:title, :source_url)
  end
end
