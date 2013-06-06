
require 'spec_helper'
require "cancan/matchers"

describe Ability do
  subject { ability }
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  context 'when is a normal user' do

    describe "submissions" do
      let(:a_submission) { Submission.new }
      let(:her_submission) do
        s = Submission.new
        s.user = user
        s
      end

      it { should be_able_to(:update, her_submission) }
      it { should be_able_to(:destroy, her_submission) }
      it { should be_able_to(:read, a_submission) }
      it { should be_able_to(:create, her_submission) }
      it { should_not be_able_to(:create, a_submission) }
      it { should_not be_able_to(:manage, a_submission) }
    end

    describe "reviews" do
      let(:a_review) { Review.new }
      let(:her_review) do
        r = Review.new
        r.user = user
        r
      end

      it { should be_able_to(:update, her_review) }
      it { should be_able_to(:destroy, her_review) }
      it { should be_able_to(:create, her_review) }
      it { should_not be_able_to(:create, a_review) }
    end
  end
end
