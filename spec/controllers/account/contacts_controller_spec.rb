require 'rails_helper'

RSpec.describe Account::ContactsController, type: :controller do
  describe "GET #index" do
    let!(:super_admin) { FactoryBot.create(:user, :super_admin) }
    it "returns a 200 status code" do
      sign_in super_admin
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe 'DELETE destroy' do
    let!(:contact) { FactoryBot.create(:contact) }
    context 'when user is SuperAdmin' do
      let!(:super_admin) { FactoryBot.create(:user, :super_admin) }
      it 'should delete the contact' do
        sign_in super_admin
        expect do
          delete :destroy, xhr: true, params: { id: contact.id }
        end.to change(Contact, :count).by(-1)
      end
    end
    context 'when user has no privilege' do
      let!(:tenant) { FactoryBot.create(:tenant) }
      it 'should not delete the comment' do
        @sale = FactoryBot.create(:user, :sale, tenant_id: tenant.id)
        sign_in @sale
        expect do
          delete :destroy, xhr: true, params: { id: contact.id }
        end.to_not change(Contact, :count)
      end
    end
  end
end
