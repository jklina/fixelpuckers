# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature do
    description "#{Faker::Lorem.paragraph}"
    association :author, factory: :user
    submission

    preview do
      fixture_file_upload( 'spec/assets/images/photo.jpg', 'image/jpeg')
    end
  end
end
