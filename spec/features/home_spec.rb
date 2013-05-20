require 'spec_helper'

describe "Home Page" do
  context "when there are no submissions" do
    it "should inform the user there are no submissions" do
      visit root_url
      page.should have_content("There are no submissions yet!")
    end
  end

  context "when there are submissions" do
    it "should display the submissions" do
      submissions = FactoryGirl.create_list(:submission, 2)
      visit root_url
      submissions.each do |submission|
        page.should have_content("#{submission.title}")
      end
    end
  end

  context "within a submission preview" do
    it "should display the submission attributes" do
      submission = FactoryGirl.create(:submission)
      visit root_url
      within(".submission-preview") do
        page.should have_link("#{submission.title}", 
                              href: submission_path(submission))
        page.should have_link("#{submission.user.username}", 
                              href: user_path(submission.user))
      end
    end
  end

  describe "pagination" do
    context "when there are enough submissions to have multiple pages" do
      it "shows the pagination menu" do
        user = FactoryGirl.create(:user)
        FactoryGirl.create_list(:submission, 7, user: user)
        visit root_url
        page.should have_selector("nav.pagination")
      end
    end

    context "when there are not enough submissions to have multiple pages" do
      it "does not show the pagination menu" do
        user = FactoryGirl.create(:user)
        FactoryGirl.create_list(:submission, 6, user: user)
        visit root_url
        page.should_not have_selector("nav.pagination")
      end
    end
  end
end
