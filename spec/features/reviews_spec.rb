require 'spec_helper'

describe "Deleting a review" do
  before(:each) do
    @user = create_logged_in_user
    @submission = FactoryGirl.create(:submission)
    @review = FactoryGirl.create(:review, user: @user)
    @submission.reviews << @review
    visit submission_path(@submission)
  end
end

describe "Viewing reviews" do
  it "shows reviews on the submission page" do
    submission = FactoryGirl.create(:submission)
    review = FactoryGirl.create(:review, submission: submission)
    visit submission_path(submission)
    expect(page).to have_content(review.comment)
  end
end

describe "Submitting a review" do
  context "when the reviewer isn't a registered user" do
    before(:each) do
      submission = FactoryGirl.create(:submission)
      visit submission_path(submission)
    end

    it "does not let a user place a review on a submission" do
      expect(page).not_to have_selector('form')
    end

    it "tells the user they can sign up to place a review" do
      expect(page).to have_content("Please sign up to leave a review.")
    end
  end

  context "when a reviewer is a registered user" do
    before (:each) do
      # @user = FactoryGirl.create(:user)
      # login @user
      @user = create_logged_in_user
      @submission = FactoryGirl.create(:submission)
    end

    it "lets a user place a review on a submission" do
      visit submission_path(@submission)
      expect(page).to have_selector('form#new_review')
    end

    context "and a review doesn't pass validation" do
      before(:each) { visit submission_path(@submission) }

      it "flashs an error message" do
        click_button('Create Review')
        within(:css, "#flash_error") do
          expect(page).to have_content('Review not saved.')
        end
      end

      it "redirects the user to the submission's show page" do
        expect(current_path).to eq(submission_path(@submission))
      end
    end

    context "and a review is created" do
      before(:each) do
        @paragraph = Faker::Lorem.paragraph
        visit submission_path(@submission)
        fill_in('Rating', with: 5)
        fill_in('Comment', with: @paragraph)
        click_button('Create Review')
      end

      it "creates a new review when one is filled out correctly" do
        review = Review.last
        expect(review.rating).to eq(5)
        expect(review.comment).to eq(@paragraph)
      end

      it "flashs a notice letting the user know the review was created" do
        within(:css, "#flash_notice") do
          expect(page).to have_content('Review was successfully created')
        end
      end

      it "redirects the user to the submission's show page" do
        expect(current_path).to eq(submission_path(@submission))
      end
    end

    context "and an existing review is updated" do
      before(:each) do
        @review = FactoryGirl.create(:review, user: @user)
        @submission.reviews << @review
        visit submission_path(@submission)
      end

      it "has the review form filled out with the existing review" do
        expect(find_field('Rating').value).to eq(@review.rating.to_s)
        expect(find_field('Comment').value).to eq(@review.comment.to_s)
      end

      it "change the existing review when the review is updated"  do
        find(:xpath, "//*[(@id = 'review_rating')]").set '44'
        find(:xpath, "//*[(@id = 'review_comment')]").set "hello"
        click_button('Update Review')
        @review.reload
        expect(@review.comment).to eq('hello')
        expect(@review.rating).to eq(44)
      end

      it "displays a message saying the review has been updated" do
        click_button('Update Review')
        within(:css, "#flash_notice") do
          expect(page).to have_content('Review was successfully updated.')
        end
      end
    end
  end
end
