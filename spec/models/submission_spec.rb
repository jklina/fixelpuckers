require 'spec_helper'

describe Submission do
  let(:submission) { create(:submission) }
  let(:trashed_submission) { create(:submission, trashed: true) }

  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }
  it { should validate_length_of(:title).is_at_most(120) }
  it { should validate_numericality_of(:views).only_integer }
  it { should validate_numericality_of(:downloads).only_integer }
  it { should validate_numericality_of(:average_rating) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:category) }
  it { should have_many(:reviews) }
  it { should have_many(:features) }

  it { should have_attached_file(:preview) }
  it { should validate_attachment_presence(:preview) }
  it { should validate_attachment_content_type(:preview).
                allowing("image/jpg", "image/jpeg", "image/png", "image/gif").
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:preview).less_than(8.megabytes) }
  it { should have_attached_file(:attachment) }
  it { should validate_attachment_content_type(:attachment).
                allowing("image/jpg", "image/jpeg", "image/png", "image/gif",
                         "application/zip", "application/x-zip").
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:attachment).less_than(25.megabytes) }

  describe "default_scope" do
    it "orders the submissions by their created date" do
      sub1 = create(:submission, created_at: Date.current - 1.day)
      sub2 = create(:submission, created_at: Date.current)
      expect(Submission.all).to eq([sub2, sub1])
    end
  end

  describe ".filtered_trash_for" do
    it "filters out trashed submissions that are not authored by the given user" do
      submission
      trashed_authored_submission =
        create(:submission,
                           author: submission.author,
                           trashed: true)
      trashed_submission = create(:submission,trashed: true)
      expect(Submission.filtered_trash_for(submission.author)).
             to eq([trashed_authored_submission, submission])
    end
  end

  describe '#find_or_build_review_from' do
    before(:each) do
      @user = double(id: 3)
      @review = double
      @submission = Submission.new
      allow(@submission).
        to receive_message_chain(:reviews, :where, :first_or_initialize).
        and_return(@review)
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
      review1 = create(:review, rating: 20)
      review2 = create(:review, rating: 10)
      submission.reviews << review1
      submission.reviews << review2
      submission.update_average_rating
      submission.reload
      expect(submission.average_rating).to eq(15)
    end
  end

  describe "#increment_views!" do
    it "increments the views attribute" do
      expect{submission.increment_views!}.
        to change{submission.views}.by(1)
      submission.reload
      expect(submission.views).to eq(1)
    end
  end

  describe "#toggle_trash!" do
    context "when a submission is trashed" do
      it "untrashes the submission and save it" do
        trashed_submission.toggle_trash!
        expect(trashed_submission.trashed?).to be_falsey
      end

      it "trashes an untrashed submission" do
        submission.toggle_trash!
        expect(submission.trashed?).to be_truthy
      end
    end
  end
end
