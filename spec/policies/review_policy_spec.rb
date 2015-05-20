require 'review_policy'

describe ReviewPolicy do
  let(:user) { double("user") }
  let(:review) { double("review", author: user) }
  let(:review_policy) { ReviewPolicy.new(user, review) }

  it "initializes with the current review and a requested review" do
    expect(review_policy.user).to eq(user)
    expect(review_policy.review).to eq(review)
  end


  shared_examples "verify that review author matches current user for" do |action|
    it "returns true if the reviews author matches the current user" do
      expect(review_policy.send(action)).to be_truthy
    end

    it "returns false if the reviews author is not the current user" do
      allow(review).to receive(:author).and_return(double("other user"))
      expect(review_policy.send(action)).to be_falsey
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
