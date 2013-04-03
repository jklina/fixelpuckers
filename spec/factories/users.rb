# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:username) {|n| "person#{n}" }
    sequence(:email) {|n| "person#{n}@example.com" }
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end
