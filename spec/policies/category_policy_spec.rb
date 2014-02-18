require 'category_policy'

describe CategoryPolicy do
  let(:admin) { double("user", admin?: true) }
  let(:user) { double("user", admin?: false) }
  let(:category) { double("category") }
  let(:valid_user_policy) { CategoryPolicy.new(admin, category) }
  let(:invalid_user_policy) { CategoryPolicy.new(user, category) }

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

  describe "#index?" do
    include_examples "verify user is admin", :edit?
  end

  describe "#edit?" do
    include_examples "verify user is admin", :edit?
  end

  describe "update?" do
    include_examples "verify user is admin", :update?
  end
end
