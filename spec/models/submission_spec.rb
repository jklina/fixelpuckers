require 'spec_helper'

describe Submission do
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:reviews) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should_not allow_mass_assignment_of(:user_id) }

  describe '#find_or_build_review_from' do
    before(:each) do
      @user = double(id: 3)
      @review = double()
      @submission = Submission.new
    end

    context 'when a user review exists for the submission' do
      before(:each) do
        @submission.stub_chain(:reviews, :where, :first).and_return(@review)
      end

      # it 'should find the review by a given user' do
      #   user = FactoryGirl.create(:user)
      #   submission = FactoryGirl.create(:submission)
      #   review = FactoryGirl.create(:review, user: user)
      #   another_review = FactoryGirl.create(:review)
      #   submission.reviews << review
      #   submission.reviews << another_review
      #   submission.find_or_build_review_from(user).should eq(review)
      # end
      it 'should not build a review for the given submission' do
        @submission.reviews.should_not_receive(:build)
        @submission.find_or_build_review_from(@user)
      end

      it 'should search for reviews from the submissions reviews' do
        @submission.should_receive(:reviews)
        @submission.find_or_build_review_from(@user)
      end

      it 'should narrow down the search to the given user' do
        @submission.reviews.should_receive(:where).with('user_id = ?', @user.id)
        @submission.find_or_build_review_from(@user)
      end

      it 'should return an individual review, not a collection' do
        @submission.reviews.where.should_receive(:first)
        @submission.find_or_build_review_from(@user)
      end
    end

    context 'when a user reviews doesnt exist for the submission' do
      it 'should build a new review for the given submission' do
        @submission.stub_chain(:reviews, :where, :first).and_return(nil)
        @submission.stub_chain(:reviews, :build)
        @submission.reviews.should_receive(:build).with(user_id: @user.id)
        @submission.find_or_build_review_from(@user)
      end
    end
  end
end
