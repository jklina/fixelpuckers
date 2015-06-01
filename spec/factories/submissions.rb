# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :submission do
    sequence(:title) {|n| "Title:#{n}" }
    description "#{Faker::Lorem.paragraph}"
    association :author, factory: :user

    # For Paperclip files
    # preview_file_name { 'spec/assets/files/photo.jpg' }
    # preview_content_type { 'image/jpg' }
    # preview_file_size { 1024 }
    preview do
      fixture_file_upload( 'spec/assets/images/photo.jpg', 'image/jpeg')
    end

    factory :invalid_submission do
      title nil
    end

    factory :submission_with_attachment do
      attachment do
        fixture_file_upload( 'spec/assets/files/photo.zip', 'application/zip')
      end
    end
  end
end
