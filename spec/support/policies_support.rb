shared_examples "an adminable policy with actions" do |actions|
  let(:admin) { double("user", admin?: true) }
  let(:user) { double("user", admin?: false) }
  let(:adminable) { double("adminable") }
  let(:valid_user_policy) { described_class.new(admin, adminable) }
  let(:invalid_user_policy) { described_class.new(user, adminable) }

  it "initializes with the current user" do
    expect(valid_user_policy.user).to eq(admin)
  end

  actions.each do |action|
    it "returns true when the current user is an admin" do
      expect(valid_user_policy.send("#{action}?")).to be_true
    end

    it "returns false when the current user is not an admin" do
      expect(invalid_user_policy.send("#{action}?")).to be_false
    end
  end
end
