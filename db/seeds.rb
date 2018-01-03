FactoryBot.create(:user, email: 'superadmin@superadmin.com', password: '1qaz2wsx', role: 'superadmin')
FactoryBot.create(:user, email: 'admin@admin.com', password: '1qaz2wsx', role: 'admin')
FactoryBot.create(:user, email: 'sale@sale.com', password: '1qaz2wsx', role: 'sale')

user = User.first

FactoryBot.create(:company, name:  'Example Company',
                            domain: 'example.org',
                            user: user)

FactoryBot.create(:company, name:  'SoftServe,Inc.',
                            domain: 'softserve.ua',
                            user: user)

FactoryBot.create(:company, name:  'Alphabet Inc.',
                            domain: 'abc.xyz',
                            user: user)

company = Company.first

FactoryBot.create_list(:page, 20, company: company)
