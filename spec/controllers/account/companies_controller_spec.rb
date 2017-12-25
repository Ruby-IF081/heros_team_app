require 'rails_helper'

RSpec.describe Account::CompaniesController, type: :controller do
  let!(:company) { create(:company) }
  before(:each) { sign_in company.user }

  describe "GET #index" do
    it "populates an array of companies" do
      get :index
      expect(assigns(:companies)).to contain_exactly(company)
    end

    it "renders the :index view" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested company to @company" do
      get :show, params: { id: company.id }
      expect(assigns(:company)).to eq(company)
    end

    it "renders the #show view" do
      get :show, params: { id: company.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "initiate empty Company" do
      get :new
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      let!(:val_company) { build(:company) }

      it "creates a new company" do
        expect do
          post :create, params: { company: { name: val_company.name,
                                             domain: val_company.domain } }
        end.to change(Company, :count).by(1)
      end

      it "redirects to the all companies" do
        post :create, params: { company: { name: val_company.name,
                                           domain: val_company.domain } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_company_path(Company.last)
      end
    end

    context "with invalid attributes" do
      let!(:inval_company) { build(:company, :invalid_domain) }

      it "does not save the new company" do
        expect do
          post :create, params: { company: { name: inval_company.name,
                                             domain: inval_company.domain } }
        end.to_not change(Company, :count)
      end

      it "re-renders the new method" do
        post :create, params: { company: { name: inval_company.name,
                                           domain: inval_company.domain } }
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    context "valid attributes" do
      it "located the requested company" do
        put :update, params: { id: company.id,
                               company: { name: company.name,
                                          domain: company.domain } }
        expect(assigns(:company)).to eq(company)
      end

      it "changes company's attributes" do
        put :update, params: { id: company.id,
                               company: { name: 'edited', domain: 'edited.com' } }
        company.reload
        expect(company.name).to eq('edited')
        expect(company.domain).to eq('edited.com')
      end

      it "redirects to the updated company" do
        put :update, params: { id: company.id,
                               company: { name: 'edited', domain: 'edited.com' } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_company_path
      end
    end

    context "invalid attributes" do
      let!(:inval_company) { build(:company, :invalid_domain) }

      it "located the requested company" do
        put :update, params: { id: company.id,
                               company: { name: company.name,
                                          domain: company.domain } }
        expect(assigns(:company)).to eq(company)
      end

      it "does not change company's attributes" do
        put :update, params: { id: company.id,
                               company: { name: inval_company.name,
                                          domain: inval_company.domain } }
        company.reload
        expect(company.name).to_not eq(inval_company.name)
        expect(company.domain).to_not eq(inval_company.domain)
      end

      it "re-renders the edit method" do
        put :update, params: { id: company.id,
                               company: { name: inval_company.name,
                                          domain: inval_company.domain } }
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the company" do
      expect { delete :destroy, params: { id: company.id } }.to change(Company, :count).by(-1)
    end

    it "redirects to company#index" do
      delete :destroy, params: { id: company.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_companies_path
    end
  end
end
