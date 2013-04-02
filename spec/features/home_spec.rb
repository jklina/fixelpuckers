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
      submissions = FactoryGirl.create_list(:submission, 5)
      visit root_url
      submissions.each do |submission|
        page.should have_content("#{submission.title}")
      end
    end
  end
end
