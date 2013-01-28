require 'spec_helper'

describe "Submitting a review" do
  context "when the reviewer isn't a registered user" do
    before(:each) do
      submission = FactoryGirl.create(:submission)
      visit submission_path(submission)
    end

    it "should not let a user place a review on a submission" do
      page.should_not have_selector('form')
    end

    it "should tell the user they can sign up to place a review" do
      page.should have_content("Please sign up to leave a review.")
    end
  end

  context "when a reviewer is a registered user" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      login @user
      @submission = FactoryGirl.create(:submission)
      visit submission_path(@submission)
    end

    it "should let a user place a review on a submission" do
      page.should have_selector('form#new_review')
    end

    context "and a review doesn't pass validation" do
      it "should flash an error message" do
        click_button('Create Review')
        within(:css, "#flash_error") do
          page.should have_content('Review not saved.')
        end
      end

      it "should redirect the user to the submission's show page" do
        current_path.should == submission_path(@submission)
      end
    end

    context "and a review is created" do
      before(:each) do
        @paragraph = Faker::Lorem.paragraph
        fill_in('Rating', with: 5)
        fill_in('Comment', with: @paragraph)
        click_button('Create Review')
      end
      it "should create a new review when one is filled out correctly" do
        review = Review.last
        review.rating.should eq(5)
        review.comment.should eq(@paragraph)
      end

      it "should flash a notice letting the user know the review was created" do
        within(:css, "#flash_notice") do
          page.should have_content('Review was successfully created')
        end
      end

      it "should redirect the user to the submission's show page" do
        current_path.should == submission_path(@submission)
      end
    end
  end
end
