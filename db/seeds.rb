FactoryBot.create(:user, email: 'example@gmail.com', password: '1qaz2wsx')

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
