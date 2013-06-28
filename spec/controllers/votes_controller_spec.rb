require 'spec_helper'

describe VotesController do
  # let(:votable) { FactoryGirl.create(:review) }
  let(:votable) { double("votable") }

  before(:each) do
    @request.env['HTTP_ACCEPT'] = "application/json"
    allow(controller).to receive(:votable).and_return(votable)
  end

  describe "POST vote_up" do
    it "adds or updates a postive vote from the logged in user" do
      rater = double
      allow(controller).to receive(:current_user).and_return(rater)
      expect(votable).to receive(:add_or_update_evaluation)
                         .with(:votes, 1, rater)
      post :vote_up, id: votable,
                     votable_type: votable.class.to_s
    end
  end

  describe "POST vote_down" do
    it "adds or updates a postive vote from the logged in user" do
      rater = double
      allow(controller).to receive(:current_user).and_return(rater)
      expect(votable).to receive(:add_or_update_evaluation)
                         .with(:votes, -1, rater)
      post :vote_down, id: votable,
                       votable_type: votable.class.to_s
    end
  end

  describe "DELETE remove_vote" do
    it "adds or updates a postive vote from the logged in user" do
      rater = double
      allow(controller).to receive(:current_user).and_return(rater)
      expect(votable).to receive(:delete_evaluation).with(:votes, rater)
      delete :remove_vote, id: votable,
                           votable_type: votable.class.to_s
    end
  end
end
