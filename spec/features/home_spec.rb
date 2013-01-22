require 'spec_helper'

describe "Home Page" do
  before(:each) do
    @submissions = FactoryGirl.create_list(:submission, 5)
    visit root_url
  end
  context "when there are no submissions" do
    it "should inform the user there are no submissions" do
      page.should have_content("There are no submissions yet!")
    end
  end

  context "where there are submissions" do
    it "should display the submissions" do
      @submissions.each do |submission|
        page.should have_content("#{submission.title}")
      end
    end
  end
end
