require 'user_policy'

describe UserPolicy do
  let(:user1) { double("user") }
  let(:user2) { double("requested user") }
  let(:valid_user_policy) { UserPolicy.new(user1, user1) }
  let(:invalid_user_policy) { UserPolicy.new(user1, user2) }

  it "initializes with the current user and a requested user" do
    expect(valid_user_policy.user).to eq(user1)
    expect(valid_user_policy.requested_user).to eq(user1)
  end

  shared_examples "verify user is requesting current user for" do |action|
    it "returns true when the current user is equal to the requested user" do
      expect(valid_user_policy.send(action)).to be_truthy
    end

    it "returns false when the current user is different from the req user" do
      expect(invalid_user_policy.send(action)).to be_falsey
    end
  end

  describe "#edit?" do
    include_examples "verify user is requesting current user for", :edit?
  end

  describe "update?" do
    include_examples "verify user is requesting current user for", :update?
  end
end
