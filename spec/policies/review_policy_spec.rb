require 'review_policy'

describe ReviewPolicy do
  let(:user) { double("user") }
  let(:review) { double("review", author: user) }
  let(:valid_review_policy) { ReviewPolicy.new(user, review) }
  # let(:invalid_review_policy) { ReviewPolicy.new(user, review2) }

  it "initializes with the current review and a requested review" do
    expect(valid_review_policy.user).to eq(user)
    expect(valid_review_policy.review).to eq(review)
  end


  shared_examples "verify that review author matches current user for" do |action|
    it "returns true if the reviews author matches the current user" do
      expect(valid_review_policy.send(action)).to be_true
    end

    it "returns false if the reviews author is not the current user" do
      allow(review).to receive(:author).and_return(double("other user"))
      expect(valid_review_policy.send(action)).to be_false
    end
  end

  describe "#destroy?" do
    include_examples "verify that review author matches current user for",
      :destroy?
  end

  describe "#edit?" do
    include_examples "verify that review author matches current user for",
      :edit?
  end

  describe "#update?" do
    include_examples "verify that review author matches current user for",
      :update?
  end
end
