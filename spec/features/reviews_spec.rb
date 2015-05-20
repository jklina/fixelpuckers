require 'spec_helper'

describe "Reviews", type: :feature do
  let(:user) { create(:user) }
  let(:submission) { create(:submission) }
  let(:paragraph) { Faker::Lorem.paragraph }

  describe "Viewing reviews" do
    it "shows reviews on the submission page" do
      review = create(:review, submission: submission)
      visit submission_path(submission)
      expect(page).to have_content(review.comment)
    end
  end

  describe "Submitting a review" do
    context "when the reviewer isn't a registered user" do
      before(:each) do
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
        visit submission_path(submission, as: user.id)
      end

      it "lets a user place a review on a submission" do
        expect(page).to have_selector('form#new_review')
      end

      context "and a review doesn't pass validation" do
        # before(:each) { visit submission_path(submission) }

        it "flashs an error message" do
          click_button('Create Review')
          within(:css, "#flash_error") do
            expect(page).to have_content('Review not saved.')
          end
        end

        it "redirects the user to the submission's show page" do
          expect(current_path).to eq(submission_path(submission))
        end
      end

      context "and a review is created" do
        before(:each) do
          visit submission_path(submission)
          fill_in('Rating', with: 5)
          fill_in('Comment', with: paragraph)
          click_button('Create Review')
        end

        it "creates a new review when one is filled out correctly" do
          review = Review.last
          expect(review.rating).to eq(5)
          expect(review.comment).to eq(paragraph)
        end

        it "flashs a notice letting the user know the review was created" do
          within(:css, "#flash_notice") do
            expect(page).to have_content('Review was successfully created')
          end
        end

        it "redirects the user to the submission's show page" do
          expect(current_path).to eq(submission_path(submission))
        end
      end

      context "and an existing review is updated" do
        before(:each) do
          @review = create(:review, author: user)
          submission.reviews << @review
          visit submission_path(submission)
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

  describe "voting on a review" do
    it "a user can vote a review positively", js: true do
      voter = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, author: user)
      submission.reviews << review
      visit submission_path(submission, as: voter.id)
      expect(page).to_not have_selector("i.ss-icon.arrow.up.active")
      click_link("up")
      expect(page).to have_selector("i.ss-icon.arrow.up.active")
      review.reload
      expect(review.likes.size).to eq(1)
      click_link("up")
      expect(page).to_not have_selector("i.ss-icon.arrow.up.active")
    end

    it "a user can vote a review negatively", js: true do
      voter = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, author: user)
      submission.reviews << review
      visit submission_path(submission, as: voter.id)
      expect(page).to_not have_selector("i.ss-icon.arrow.down.active")
      click_link("down")
      expect(page).to have_selector("i.ss-icon.arrow.down.active")
      review.reload
      expect(review.dislikes.size).to eq(1)
      click_link("down")
      expect(page).to_not have_selector("i.ss-icon.arrow.down.active")
    end
  end

  describe "Deleting a review", js: true do
    it "allows the user to delete their review" do
      reviewer = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, author: reviewer)
      submission.reviews << review
      visit submission_path(submission, as: reviewer.id)
      expect(page).to have_content('1 Review')
      find("#action-delete-review", visible: false).click
      sleep 1
      expect(Review.all.size).to eq(0)
      expect(page).to have_content('0 Reviews')
    end
  end
end
