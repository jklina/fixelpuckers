require 'submission_policy'

describe SubmissionPolicy do
  let(:user) { double("user") }
  let(:submission) { double("submission", author: user) }
  let(:submission_policy) { SubmissionPolicy.new(user, submission) }

  it "initializes with the current user and a submission" do
    expect(submission_policy.user).to eq(user)
    expect(submission_policy.submission).to eq(submission)
  end

  shared_examples "verify user is the author for" do |action|
    it "returns true when the current user is the author" do
      expect(submission_policy.send(action)).to be_true
    end

    it "returns false when the current user isn't the author" do
      allow(submission).to receive(:author).and_return(double("other user"))
      expect(submission_policy.send(action)).to be_false
    end
  end

  describe "#edit?" do
    include_examples "verify user is the author for", :edit?
  end

  describe "#trash?" do
    include_examples "verify user is the author for", :trash?
  end

  describe "update?" do
    include_examples "verify user is the author for", :update?
  end
end
