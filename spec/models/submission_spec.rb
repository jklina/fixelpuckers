require 'spec_helper'

describe Submission do
  let(:submission) { FactoryGirl.create(:submission) }

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
      @user = double(id: 3)
      @review = double
      @submission = Submission.new
      @submission.stub_chain(:reviews, :where, :first_or_initialize).and_return(@review)
    end

    it 'attempts to find a review' do
      expect(@submission).to receive(:reviews)
      @submission.find_or_build_review_from(@user)
    end

    it 'attempts to find a review by a given user' do
      expect(@submission.reviews).to receive(:where).with(user_id: @user.id)
      @submission.find_or_build_review_from(@user)
    end

    it 'returns either the first review found or initialize a new review' do
      expect(@submission.reviews.where).to receive(:first_or_initialize)
      @submission.find_or_build_review_from(@user)
    end
  end

  describe "#update_average_rating" do
    it "updates the submission's average rating in the db" do
      review1 = FactoryGirl.create(:review, rating: 20)
      review2 = FactoryGirl.create(:review, rating: 10)
      submission.reviews << review1
      submission.reviews << review2
      submission.update_average_rating
      submission.reload
      expect(submission.average_rating).to eq(15)
    end
  end

end
