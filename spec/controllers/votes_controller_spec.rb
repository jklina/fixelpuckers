require 'spec_helper'

describe VotesController do
  # Doing integration testing here because of the polymorphic stuffs.
  # Using a Review as my base polymorphic example
  let(:votable) { FactoryGirl.create(:review) }
  let(:rater) { FactoryGirl.create(:user) }

  before(:each) do
    @request.env['HTTP_ACCEPT'] = "application/json"
    allow(controller).to receive(:current_user).and_return(rater)
  end

  describe "POST up" do
    it "adds or updates a postive vote from the logged in user" do
      post :up, votable_id: votable,
           votable_type: votable.class.to_s
      expect(votable.reputation_for(:votes)).to eq(1)
    end
  end

  describe "POST down" do
    it "adds or updates a postive vote from the logged in user" do
      post :down, votable_id: votable,
                  votable_type: votable.class.to_s
      expect(votable.reputation_for(:votes)).to eq(-1)
    end
  end

  describe "DELETE destroy" do
    it "adds or updates a postive vote from the logged in user" do
      votable.add_or_update_evaluation(:votes, 1, rater)
      delete :destroy, votable_id: votable, votable_type: votable.class.to_s
      expect(votable.reputation_for(:votes)).to eq(0)
    end
  end
end
