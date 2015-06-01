require 'spec_helper'

describe "Features", type: :feature do
  let(:admin) { create(:admin) }
  let(:feature) { create(:feature) }

  describe "Featuring a submission" do
    it "creates a new feature" do
      submission = create(:submission)
      visit(submission_path(submission, as: admin.id))
      click_link("Feature")
      expect(current_path).to eq(admin_new_feature_path(submission))
      fill_in("Description", with: "Great sub")
      click_button("Create Feature")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Great sub")
      expect(feature.submission).to eq(submission)
    end
  end

  describe "editing" do
    it "changes an existing feature" do
      visit(edit_admin_feature_path(feature, as: admin.id))
      expect(find_field('feature_description').value).
        to eq(feature.description)
      fill_in("Description", with: "Great sub")
      click_button("Update Feature")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Feature was successfully updated.")
      expect(page).to have_content("Great sub")
    end
  end

  describe "deleting" do
    it "let's an admin delete a feature" do
      feature
      visit(features_path(as: admin.id))
      click_link("delete")
      expect(page).to_not have_content("delete")
    end
  end
end
