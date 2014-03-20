require 'spec_helper'

describe Feature do
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:submission) }

  it "has a default scope that orders by created_at, desc" do
    feature1 = FactoryGirl.create(:feature)
    feature2 = FactoryGirl.create(:feature)

    expect(Feature.all).to eq([feature2, feature1])
  end
end
