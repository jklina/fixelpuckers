FactoryGirl.define do
  factory :user do
    name 'Test User'
    username { Faker::Internet.user_name}
    email { Faker::Internet.email }
    password 'password'
  end
end
