tenant = Tenant.create(name: "SoftServe")

if Rails.env.production?
  User.create(first_name: "John", last_name: "Smith", email: "test@test.com", role: "super_admin", password: "superteam", tenant: tenant)
  User.create(first_name: "Bill", last_name: "Gates", email: "egor@google.com", role: "admin", password: "superteam", tenant: tenant)
  User.create(first_name: "Mark", last_name: "Tsukerberg", email: "egor@tesla.com", role: "sale", password: "superteam", tenant: tenant)
end

if Rails.env.development?
  user = FactoryBot.create(:user, email: 'admin@admin.com', password: '1qaz2wsx', role: 'admin')
  FactoryBot.create(:user, email: 'super_admin@super_admin.com', password: '1qaz2wsx', role: 'super_admin')
  FactoryBot.create(:user, email: 'sale@sale.com', password: '1qaz2wsx', role: 'sale')

  company = FactoryBot.create(:company, name:  'Google',
                                        domain: 'google.com',
                                        user: user)

  FactoryBot.create(:company, name:  'SoftServe,Inc.',
                              domain: 'softserve.ua',
                              user: user)

  FactoryBot.create(:company, name:  'Alphabet Inc.',
                              domain: 'abc.xyz',
                              user: user)

  FactoryBot.create_list(:video, 20, videoable: company)

  FactoryBot.create_list(:page, 20, :with_content, company: company)

  FactoryBot.create_list(:tenant, 10)

  FactoryBot.create_list(:page, 20, :with_content, company: company)

  FactoryBot.create_list(:user, 200, :old_random_date, role: 'sale', tenant: tenant)

  FactoryBot.create_list(:company, 200, :old_random_date, user: user)

  FactoryBot.create_list(:visit, 200, :old_random_date, user: user, tenant_id: tenant.id)
end


