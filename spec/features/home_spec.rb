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
        page.should have_link("#{submission.title}")
        page.should have_link("#{submission.user.username}")
      end
    end
  end
end
