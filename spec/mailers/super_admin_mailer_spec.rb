require 'rails_helper'

RSpec.describe SuperAdminMailer, type: :mailer do
  describe 'daily user creation notification' do
    context 'with super admins present' do
      let!(:user) { FactoryBot.create(:user, :super_admin) }
      let!(:mail) { SuperAdminMailer.daily_user_creation_notification }

      it 'renders the headers' do
        expect(mail.subject).to eq('Users created on the previous day')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(['salesassistant@mail.com'])
      end

      it 'renders the body' do
        expect(mail.body).to match(user.first_name)
        expect(mail.body).to match(user.email)
      end

      it 'delivers the email' do
        expect do
          SuperAdminMailer.daily_user_creation_notification.deliver
        end.to change(ActionMailer::Base.deliveries, :size).by(1)
      end
    end

    context 'without super admins present' do
      let!(:mail) { SuperAdminMailer.daily_user_creation_notification }

      it 'should not send any mails' do
        expect do
          SuperAdminMailer.daily_user_creation_notification.deliver
        end.to change(ActionMailer::Base.deliveries, :size).by(0)
      end
    end
  end
end
