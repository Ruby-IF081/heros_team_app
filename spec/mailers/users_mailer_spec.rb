require 'rails_helper'

RSpec.describe UsersMailer, type: :mailer do
  describe 'credentials views' do
    let!(:user) { FactoryBot.create(:user, :sale) }
    let!(:mail) { UsersMailer.credentials(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your credentials')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['salesassistant@mail.com'])
    end

    it 'renders the body' do
      expect(mail.body).to match(user.first_name)
      expect(mail.body).to match(user.email)
    end
  end
end
