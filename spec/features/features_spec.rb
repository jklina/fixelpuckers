require 'spec_helper'

describe "Features" do
  describe "Featuring a submission" do
    it "can be done by an admin" do
      admin = FactoryGirl.create(:admin)
      submission = FactoryGirl.create(:submission)
      visit(submission_path(submission, as: admin.id))
      click_link("Feature")
      expect(current_path).to eq(admin_new_feature_path(submission))
      fill_in("Description", with: "Great sub")
      click_button("Create Feature")
      expect(current_path).to eq(root_path)
      feature = Feature.last
      expect(feature.description).to eq("Great sub")
      expect(feature.submission).to eq(submission)
    end
  end
end
