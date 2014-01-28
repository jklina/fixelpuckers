require 'spec_helper'

describe "Home Page" do
  context "when there are no submissions" do
    it "informs the user there are no submissions" do
      visit root_url
      expect(page).to have_content("There are no submissions yet!")
    end
  end

  context "when there are submissions" do
    it "displays the submissions" do
      submissions = FactoryGirl.create_list(:submission, 2)
      visit root_url
      submissions.each do |submission|
        expect(page).to have_content("#{submission.title}")
      end
    end
  end

  context "within a submission preview" do
    it "displays the submission attributes" do
      submission = FactoryGirl.create(:submission)
      visit root_url
      within("[data-role='submission-preview']") do
        expect(page).to have_link("#{submission.title}", 
                              href: submission_path(submission))
        expect(page).to have_link("#{submission.author.username}", 
                              href: user_path(submission.author))
      end
    end
  end

  describe "pagination" do
    context "when there are enough submissions to have multiple pages" do
      it "shows the pagination menu" do
        user = FactoryGirl.create(:user)
        FactoryGirl.create_list(:submission, 7, author: user)
        visit root_url
        expect(page).to have_selector("nav.pagination")
      end
    end

    context "when there are not enough submissions to have multiple pages" do
      it "does not show the pagination menu" do
        user = FactoryGirl.create(:user)
        FactoryGirl.create_list(:submission, 6, author: user)
        visit root_url
        expect(page).not_to have_selector("nav.pagination")
      end
    end
  end
end
