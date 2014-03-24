require 'spec_helper'

describe "Features" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:feature) { FactoryGirl.create(:feature) }

  describe "viewing a feature" do
    it "let's us view the homepage if there are no features" do
      visit(root_path)
      expect(page).to have_content("Pixelfuckers")
    end

    it "displays the feature author and description on the homepage" do
      feature = FactoryGirl.create(:feature)
      visit(root_path)
      expect(page).to have_content(feature.author.username)
      expect(page).to have_content(feature.description)
    end
  end

  describe "Featuring a submission" do
    it "creates a new feature" do
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

  describe "editing" do
    it "changes an existing feature" do
      visit(edit_admin_feature_path(feature, as: admin.id))
      expect(find_field('feature_description').value).
        to eq(feature.description)
      fill_in("Description", with: "Great sub")
      click_button("Update Feature")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Feature was successfully updated.")
      feature.reload
      expect(feature.description).to eq("Great sub")
    end
  end

  describe "viewing" do
    it "lets any user view a list of submissions that were featured" do
      feature
      visit(features_path)
      expect(page).to have_content(feature.description)
      expect(page).to have_content(feature.author)
    end
  end

  describe "deleting" do
    it "let's an admin delete a feature" do
      feature
      visit(features_path(as: admin.id))
      click_link("delete")
      expect(Feature.last).to be_nil
    end
  end
end
