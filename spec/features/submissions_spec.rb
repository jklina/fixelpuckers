require 'spec_helper'

describe "Submission page" do
  before (:each) do
    @submission = FactoryGirl.create(:submission)
    visit submission_path(@submission)
  end

  it "shows the submission's title" do
    page.should have_content(@submission.title)
  end

  it "shows the submission's user's username" do
    page.should have_content(@submission.user.username)
  end

  context "when there are reviews" do 
    before (:each) do
      @submission = FactoryGirl.create(:submission)
    end

    it "lists reviews" do
      review = FactoryGirl.create(:review)
      @submission.reviews << review
      visit submission_path(@submission)
      page.should have_content(review.comment)
      page.should have_content(review.rating)
    end
  end

  context "when a guest visits" do
    before(:each) do
      @submission = FactoryGirl.create(:submission)
      visit submission_path(@submission)
    end

    it "allows the guest to access the submission" do
      current_path.should == submission_path(@submission)
    end

    it "asks the user to sign up to leave a review" do
      page.should have_content("Please sign up to leave a review.")
    end

    it "doesn't show a review form" do
      page.should_not have_selector('form')
    end
  end
end
