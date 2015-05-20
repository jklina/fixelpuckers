require 'spec_helper'

describe "Viewing a submission", type: :feature do
  let(:submission) { create(:submission) }

  context "as a guest" do
    before (:each) do
      visit submission_path(submission)
    end

    it "uses friendly urls" do
      expect(submission.to_param).to eq(submission.slug)
    end

    it "shows the submission's title" do
      expect(page).to have_content(submission.title)
    end

    it "shows the submission's user's username" do
      expect(page).to have_content(submission.author.username)
    end

    it "shows the submission's date" do
      expect(page).to have_content(submission.created_at.strftime("%B %-d, %Y"))
    end

    it "shows the submisson's description" do
      expect(page).to have_content(submission.description)
    end

    it "shows the submission's number of reviews" do
      expect(page).to have_content("#{submission.reviews.count} Reviews")
    end

    it "shows the submission's number of views" do
      submission.increment_views!
      expect(page).to have_content("#{submission.views}")
    end

    it "shows the submission's number of downloads" do
      expect(page).to have_content("#{submission.downloads} Downloads")
    end

    it "allows the guest to access the submission" do
      expect(current_path).to eq(submission_path(submission))
    end

    it "asks the user to sign up to leave a review" do
      expect(page).to have_content("Please sign up to leave a review.")
    end

    it "doesn't show a review form" do
      expect(page).to_not have_selector('form')
    end

    context "when the submission has ratings" do
      it "shows the average user rating" do
        average_rating = rand(0..100)
        submission.average_rating = average_rating
        submission.save!
        visit submission_path(submission)
        expect(page).to have_content("#{submission.average_rating}")
      end
    end


    context "when the submission has no ratings" do
      it "does not show the average user rating" do
        submission.average_rating = nil
        submission.save!
        visit submission_path(submission)
        expect(page).to have_content("User Rating: None")
      end
    end

    context "when the submission is featured" do
      it "does show the submission's featured date" do
        submission.featured_at = Date.today
        submission.save!
        visit submission_path(submission)
        expect(page).to have_content("Featured: #{submission.featured_at}")
      end
    end

    context "when the submission isn't featured" do
      it "does not show the submission's featured date" do
        submission.featured_at = nil
        submission.save!
        visit submission_path(submission)
        expect(page).to_not have_content("Featured: #{submission.featured_at}")
      end
    end

    context "when there are reviews" do 
      before (:each) do
        submission = create(:submission)
      end

      it "lists reviews" do
        review = create(:review)
        submission.reviews << review
        visit submission_path(submission)
        expect(page).to have_content(review.comment)
        expect(page).to have_content(review.rating)
      end
    end
  end
end

describe "Creating a submission", type: :feature do
  let(:author) { create(:user) }

  it "let's a logged in user create a submission" do
    visit(new_submission_path(as: author.id))
    fill_in("Title", with: "Sub1")
    fill_in("Description", with: "meh notes")
    click_button("Create Submission")
    submission = Submission.last
    expect(submission.title).to eq("Sub1")
    expect(submission.description).to eq("meh notes")
    expect(current_path).to eq(submission_path(submission))
  end
end

describe "Trashing a submission", type: :feature do
  let(:submission) { create(:submission) }
  context "when the current user is the author" do
    before(:each) do
      visit(submission_path(submission, as: submission.author.id))
    end
    it "is available on author's submission" do
      expect(page).to have_content("Trash")
    end

    it "is trashed when the author clicks the trashed link" do
      click_link("Trash")
      expect(page).to have_content("This submission is trashed.")
      submission.reload
      expect(submission.trashed?).to be_truthy
      click_link("Un-Trash")
      expect(page).to have_content("This submission is un-trashed.")
      submission.reload
      expect(submission.trashed?).to be_falsey
    end
  end

  context "when the current user isn't the author" do
    it "is available on author's submission" do
      visit(submission_path(submission, as: create(:user).id))
      expect(page).to_not have_content("Trash")
    end
  end
end

describe "Editing a submission", type: :feature do
  let(:submission) { create(:submission) }

  context "when the current user is the author" do
    it "is available" do
      visit(submission_path(submission, as: submission.author.id))
      expect(page).to have_content("Edit")
    end

    it "updates the submission" do
      category = create(:category)
      visit(edit_submission_path(submission, as: submission.author.id))
      expect(find_field('submission_title').value).to eq(submission.title)
      expect(find_field('submission_description').value).
        to eq(submission.description)
      fill_in('Title', with: "Meh Title")
      fill_in('Description', with: "Meh Description")
      select(category.name, from: 'Category')
      click_button("Update Submission")
      expect(current_path).to eq(submission_path(submission))
      expect(page).to have_content("Submission was successfully updated.")
      submission.reload
      expect(submission.title).to eq("Meh Title")
      expect(submission.description).to eq("Meh Description")
      expect(submission.category).to eq(category)
    end
  end

  context "when the current user isn't the author" do
    it "isn't available" do
      visit(submission_path(submission, as: create(:user).id))
      expect(page).to_not have_content("Edit")
    end
  end
end
