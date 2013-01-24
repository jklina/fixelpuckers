require 'spec_helper'

describe "Submitting a review" do
  context "when the reviewer isn't a registered user" do
    it "should not let a user place a review on a submission" do
      submission = FactoryGirl.create(:submission)
      visit submission_path(submission)
      page.should_not have_selector('form')
    end
  end
end

# describe "Reviews" do
#   describe "GET /reviews" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get reviews_path
#       response.status.should be(200)
#     end
#   end
# end
