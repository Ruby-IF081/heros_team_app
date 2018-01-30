FactoryBot.define do
  factory :comment, class: Comment do
    association :commentable, factory: :company
    body { Faker::Lorem.paragraphs(1).join }
    after(:build) do |comment|
      user = comment.commentable.user
      comment.user_id = user.id
      comment.tenant_id = user.tenant_id
    end
  end
end
