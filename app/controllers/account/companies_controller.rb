class Account::CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = current_user.companies.all.page(params[:page]).per(4)
  end

  def show
    @company = current_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.build(company_params)
    FullContactCompanyProcessor.new(company: @company).process
    if @company.save
      flash[:success] = "Company successfully created"
      NewCompanyWorker.perform_async(@company.id)
      redirect_to account_company_path(@company)
    else
      render :new
    end
  end

  def edit
    @company = current_company
  end

  def update
    @company = current_company
    if @company.update_attributes(company_params)
      flash[:success] = "Company updated"
      redirect_to account_company_path
    else
      render :edit
    end
  end

  def destroy
    @company = current_company
    @company.destroy
    flash[:success] = "Company deleted"
    redirect_to account_companies_path
  end

  def download
    respond_to do |format|
      format.pdf do
        render pdf: "Company #{current_company.name}.pdf",
               template: 'account/companies/show',
               layout: 'application',
               locals: { company: current_company }
      end
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :domain)
  end

  def current_company
    current_user.companies.find(params[:id])
  end
end
