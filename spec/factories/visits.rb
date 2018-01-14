FactoryBot.define do
  factory :visit, class: Visit do
    user
    created_at { rand(3.month.ago..Time.now) }
  end
end