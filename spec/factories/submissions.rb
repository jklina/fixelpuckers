# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sequence(:title) {|n| "Title:#{n}" }
    description "#{Faker::Lorem.paragraph}"
    user
  end
end
