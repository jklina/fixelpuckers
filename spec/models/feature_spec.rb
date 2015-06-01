require 'spec_helper'

describe Feature do
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:submission) }

  it { should have_attached_file(:preview) }
  it { should validate_attachment_presence(:preview) }
  it { should validate_attachment_content_type(:preview).
                allowing("image/jpg", "image/jpeg", "image/png", "image/gif").
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:preview).less_than(8.megabytes) }

  it "has a default scope that orders by created_at, desc" do
    feature1 = FactoryGirl.create(:feature)
    feature2 = FactoryGirl.create(:feature)

    expect(Feature.all).to eq([feature2, feature1])
  end
end
