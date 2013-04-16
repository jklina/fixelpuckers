# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    comment "MyText"
    user

    factory :invalid_review do
      rating 'hi'
      comment nil
      user nil
    end
  end
end
