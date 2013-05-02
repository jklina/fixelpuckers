# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sequence(:title) {|n| "Title:#{n}" }
    description "#{Faker::Lorem.paragraph}"
    user

    factory :invalid_submission do
      title nil
    end
  end
end
