module Account
  class CompaniesController < ApplicationController
    before_action :authenticate_user!

    def index
      @companies = Company.all
    end

    def show
      @company = current_company
    end

    def new
      @company = Company.new
    end

    def create
      @company = current_user.companies.build(company_params)
      if @company.save
        redirect_to account_companies_path
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
        redirect_to account_company_path
      else
        render :edit
      end
    end

    def destroy
      @company = current_company
      @company.destroy
      redirect_to account_companies_path
    end

    private

    def company_params
      params.require(:company).permit(:name, :domain)
    end

    def current_company
      Company.find(params[:id])
    end
  end
end
