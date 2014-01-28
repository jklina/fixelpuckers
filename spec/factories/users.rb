FactoryGirl.define do
  factory :user do
    name 'Test User'
    username { Faker::Internet.user_name.truncate(15) }
    email { Faker::Internet.email }
    password 'password'
  end
end
