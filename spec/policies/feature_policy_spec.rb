require 'feature_policy'

describe FeaturePolicy do
  let(:admin) { double("user", admin?: true) }
  let(:user) { double("user", admin?: false) }
  let(:feature) { double("feature") }
  let(:valid_user_policy) { FeaturePolicy.new(admin, feature) }
  let(:invalid_user_policy) { FeaturePolicy.new(user, feature) }

  it "initializes with the current user" do
    expect(valid_user_policy.user).to eq(admin)
  end

  shared_examples "verify user is admin" do |action|
    it "returns true when the current user is an admin" do
      expect(valid_user_policy.send(action)).to be_true
    end

    it "returns false when the current user is not an admin" do
      expect(invalid_user_policy.send(action)).to be_false
    end
  end

  describe "#new?" do
    include_examples "verify user is admin", :new?
  end

  describe "#create?" do
    include_examples "verify user is admin", :create?
  end

  describe "#edit?" do
    include_examples "verify user is admin", :edit?
  end

  describe "update?" do
    include_examples "verify user is admin", :update?
  end
end
