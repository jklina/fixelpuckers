require 'spec_helper'

describe "Submission page" do
  before (:each) do
    @submission = FactoryGirl.create(:submission)
    visit submission_path(@submission)
  end

  it "uses friendly urls" do
    expect(@submission.to_param).to eq(@submission.slug)
  end

  it "shows the submission's title" do
    expect(page).to have_content(@submission.title)
  end

  it "shows the submission's user's username" do
    expect(page).to have_content(@submission.user.username)
  end

  it "shows the submission's date" do
    expect(page).to have_content(@submission.created_at.strftime("%B %-d, %Y"))
  end

  it "shows the submisson's description" do
    expect(page).to have_content(@submission.description)
  end

  it "shows the submission's number of reviews" do
    expect(page).to have_content("#{@submission.reviews.count} Reviews")
  end

  it "shows the submission's number of views" do
    expect(page).to have_content("#{@submission.views} Views")
  end

  it "shows the submission's number of downloads" do
    expect(page).to have_content("#{@submission.downloads} Downloads")
  end

  context "when the submission has ratings" do
    it "shows the average user rating" do
      average_rating = rand(0..100)
      @submission.average_rating = average_rating
      @submission.save!
      visit submission_path(@submission)
      expect(page).to have_content("#{@submission.average_rating}")
    end
  end

  context "when the submission has no ratings" do
    it "does not show the average user rating" do
      @submission.average_rating = nil
      @submission.save!
      visit submission_path(@submission)
      expect(page).to have_content("User Rating: None")
    end
  end

  context "when the submission is featured" do
    it "does show the submission's featured date" do
      @submission.featured_at = Date.today
      @submission.save!
      visit submission_path(@submission)
      expect(page).to have_content("Featured: #{@submission.featured_at}")
    end
  end

  context "when the submission isn't featured" do
    it "does not show the submission's featured date" do
      @submission.featured_at = nil
      @submission.save!
      visit submission_path(@submission)
      expect(page).to_not have_content("Featured: #{@submission.featured_at}")
    end
  end

  context "when there are reviews" do 
    before (:each) do
      @submission = FactoryGirl.create(:submission)
    end

    it "lists reviews" do
      review = FactoryGirl.create(:review)
      @submission.reviews << review
      visit submission_path(@submission)
      expect(page).to have_content(review.comment)
      expect(page).to have_content(review.rating)
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
      expect(page).to have_content("Please sign up to leave a review.")
    end

    it "doesn't show a review form" do
      expect(page).to_not have_selector('form')
    end
  end
end
