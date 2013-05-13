require 'spec_helper'

describe Submission do
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }
  it { should ensure_length_of(:title).is_at_most(120) }
  it { should validate_numericality_of(:views).only_integer }
  it { should validate_numericality_of(:downloads).only_integer }
  it { should validate_numericality_of(:average_rating) }

  it { should belong_to(:user) }
  it { should have_many(:reviews) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:views) }
  it { should_not allow_mass_assignment_of(:downloads) }
  it { should_not allow_mass_assignment_of(:average_rating) }
  it { should_not allow_mass_assignment_of(:featured_at) }

  describe '#find_or_build_review_from' do
    before(:each) do
      @user = stub(id: 3)
      @review = stub()
      @submission = Submission.new
      @submission.stub_chain(:reviews, :where, :first_or_initialize).and_return(@review)
    end

    it 'attempts to find a review' do
      @submission.should_receive(:reviews)
      @submission.find_or_build_review_from(@user)
    end

    it 'attempts to find a review by a given user' do
      @submission.reviews.should_receive(:where).with(user_id: @user.id)
      @submission.find_or_build_review_from(@user)
    end

    it 'returns either the first review found or initialize a new review' do
      @submission.reviews.where.should_receive(:first_or_initialize)
      @submission.find_or_build_review_from(@user)
    end
  end

  context "when a review is added" do
    it "updates its average rating" do
      submission = submission_with_rated_reviews(2)
      num_of_reviews = submission.reviews.count
      average_rating = submission.reviews.inject(0) do |sum, review|
        sum + review.rating
      end.to_f / num_of_reviews
      expect(submission.average_rating).to eq(average_rating)
    end
  end

  context "when a review is removed" do
    it "updates its average rating" do
      submission = submission_with_rated_reviews(3)
      submission.reviews.delete(submission.reviews.last)
      num_of_reviews = submission.reviews.count
      average_rating = submission.reviews.inject(0) do |sum, review|
        sum + review.rating
      end.to_f / num_of_reviews
      expect(submission.average_rating).to eq(average_rating)
    end
  end

  def submission_with_rated_reviews(number_of_reviews)
    submission = FactoryGirl.create(:submission)
    number_of_reviews.times.each do |n|
      rating = rand(1..100)
      review = FactoryGirl.create(:review, rating: rating)
      submission.reviews << review
    end
    return submission
  end
end
