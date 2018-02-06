require 'rails_helper'
require 'rake'

describe 'daily super_admin user creation notification rake task' do
  let!(:user) { FactoryBot.create(:user, :super_admin) }
  before :all do
    Rake.application = Rake::Application.new
    Rake.application.rake_require 'lib/tasks/superadmin_user_creation_notification',
                                  [Rails.root.to_s]
    Rake::Task.define_task :environment
  end

  describe 'superadmin_user_creation_notifications:send' do
    it 'should trigger super_admin daily mailer' do
      expect do
        Rake::Task["superadmin_user_creation_notifications:send"].invoke
      end.to change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end
end
