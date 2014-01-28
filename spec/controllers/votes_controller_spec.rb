require 'spec_helper'

describe VotesController do
  let(:review) { FactoryGirl.create(:review) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(stub_model(User))
  end

  describe "PATCH up" do
    it "finds the votable with the given id" do
      xhr :patch, :up, { id: review, type: 'review' }
      review.reload
      expect(review.upvotes.size).to eq(1)
    end
  end

  describe "PATCH down" do
    it "finds the votable with the given id" do
      xhr :patch, :down, { id: review, type: 'review' }
      review.reload
      expect(review.downvotes.size).to eq(1)
    end
  end
end
