require 'spec_helper'

describe Review do
  let(:review) { FactoryGirl.create(:review) }
  let(:rater) { FactoryGirl.create(:user) }

  it { should validate_presence_of(:body) }

  it { should belong_to(:submission) }
  it { should belong_to(:user) }

  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:rating) }

  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:submission_id) }

  describe "reputation" do 
    # Basic integration testing against gem's API

    it "allows voting for a review" do
      review.add_or_update_evaluation(:votes, 1, rater)
      expect(review.reputation_for(:votes)).to eq(1)
    end

    it "sums the up and down votes" do
      rater2 = FactoryGirl.create(:user)
      rater3 = FactoryGirl.create(:user)
      review.add_evaluation(:votes, 1, rater)
      review.add_evaluation(:votes, -1, rater2)
      review.add_evaluation(:votes, -1, rater3)
      expect(review.reputation_for(:votes)).to eq(-1)
    end

    it "allows for votes to be removed" do
      review.add_or_update_evaluation(:votes, 1, rater)
      review.delete_evaluation(:votes, rater)
      expect(review.reputation_for(:votes)).to eq(0)
    end
  end
end
