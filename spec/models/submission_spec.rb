require 'spec_helper'

describe Submission do
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }
  it { should ensure_length_of(:title).is_at_most(120) }

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
      @submission.stub_chain(:reviews, :where, :first_or_initialize).and_return(@review)
    end

    it 'should attempt to find a review' do
      @submission.should_receive(:reviews)
      @submission.find_or_build_review_from(@user)
    end

    it 'should attempt to find a review by a given user' do
      @submission.reviews.should_receive(:where).with(user_id: @user.id)
      @submission.find_or_build_review_from(@user)
    end

    it 'should return either the first review found or initialize a new review' do
      @submission.reviews.where.should_receive(:first_or_initialize)
      @submission.find_or_build_review_from(@user)
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
  end
end
