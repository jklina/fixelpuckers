require 'spec_helper'

describe Review do
  it { should validate_presence_of(:comment) }

  it { should belong_to(:submission) }
  it { should belong_to(:author).class_name('User') }

  it_behaves_like "a votable"

  describe "#selector" do
    it "returns a unique css selector string" do
      review = FactoryGirl.create(:review)
      expect(review.selector).to eq("review-#{review.id}")
    end
  end
end
