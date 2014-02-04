require 'spec_helper'

describe VotesController do
  let(:review) { FactoryGirl.create(:review) }
  let(:user) { stub_model(User) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "PATCH up" do
    it "adds a vote to the votable if the user didn't already vote up" do
      xhr :patch, :up, { id: review, type: 'review' }
      review.reload
      expect(review.upvotes.size).to eq(1)
    end

    it "cancels the vote if the user had already voted up" do
      review.liked_by user
      xhr :patch, :up, { id: review, type: 'review' }
      review.reload
      expect(review.upvotes.size).to eq(0)
    end
  end

  describe "PATCH down" do
    it "finds the votable with the given id" do
      xhr :patch, :down, { id: review, type: 'review' }
      review.reload
      expect(review.downvotes.size).to eq(1)
    end

    it "cancels the vote if the user had already voted down" do
      review.disliked_by user
      xhr :patch, :down, { id: review, type: 'review' }
      review.reload
      expect(review.downvotes.size).to eq(0)
    end
  end
end
