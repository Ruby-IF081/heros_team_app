class Account::ChromeExtensionController < ApplicationController
  before_action :authenticate_user!

  def new
    @companies = current_user.companies.all
    @page = Page.new(source_url: params[:source_url])
  end

  def create
    @company = current_user.companies.find(params[:page][:company_id])
    @page = @company.pages.build(page_params)
    @page.page_type = Page::CHROME_EXTENSION
    @page.status = Page::PENDING_STATUS
    if @page.save
      flash[:success] = 'Page successfully added'
      redirect_to account_company_pages_path(@company)
    else
      render :new
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :source_url)
  end
end
