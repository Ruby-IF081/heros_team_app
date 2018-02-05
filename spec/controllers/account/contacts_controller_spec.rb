require 'rails_helper'

RSpec.describe Account::ContactsController, type: :controller do
  describe 'DELETE destroy' do
    let!(:contact) { FactoryBot.create(:contact) }
    render_views
    context 'when user is SuperAdmin' do
      it 'should delete the contact' do
        @super_admin = FactoryBot.create(:user, :super_admin)
        sign_in @super_admin
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
