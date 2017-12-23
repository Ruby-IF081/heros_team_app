FactoryBot.create(:user, email: 'admin@admin.com', password: '1qaz2wsx', role: 'admin')
FactoryBot.create_list(:tenant, 20)
FactoryBot.create_list(:page, 20)
