# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature do
    description "#{Faker::Lorem.paragraph}"
    association :author, factory: :user
    submission
  end
end
