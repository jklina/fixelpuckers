# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sequence(:title) {|n| "Title:#{n}" }
    description "#{Faker::Lorem.paragraph}"
    association :author, factory: :user

    # For Paperclip files
    preview_file_name { 'test.jpg' }
    preview_content_type { 'image/jpg' }
    preview_file_size { 1024 }

    factory :invalid_submission do
      title nil
    end

    factory :submission_with_attachment do
      attachment_file_name { 'test.zip' }
      attachment_content_type { 'application/zip' }
      attachment_file_size { 1024 }
    end
  end
end
