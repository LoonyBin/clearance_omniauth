FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { generate(:email) }
    password { "password123" }
  end

  factory :authentication, class: "ClearanceOmniauth::Authentication" do
    user
    provider { "twitter" }
    sequence(:uid) { |n| "uid_#{n}" }
  end
end
