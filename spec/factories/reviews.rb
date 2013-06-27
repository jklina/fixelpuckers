# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    body "MyText"
    user

    factory :invalid_review do
      rating 'hi'
      body nil
      user nil
    end
  end
end
