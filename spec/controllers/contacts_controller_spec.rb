require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let!(:valid_contact) { FactoryBot.create(:contact) }
  describe 'POST create' do
    render_views
    context 'with valid attributes' do
      it 'should create a new contact' do
        expect do
          post :create, xhr: true, params: { contact:
                                           { name: valid_contact.name,
                                             phone: valid_contact.phone,
                                             email: valid_contact.email,
                                             message:  valid_contact.message } }
        end.to change(Contact, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'should not create a new contact' do
        expect do
          post :create, xhr: true, params: { contact:
                                           { name: valid_contact.name,
                                             phone: valid_contact.phone,
                                             email: ' ',
                                             message: valid_contact.message } }
        end.to_not change(Contact, :count)
      end
    end
  end
end
