# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news_article do
    title { Faker::Company.catch_phrase }
    story { Faker::Company.bs }
  end
end
