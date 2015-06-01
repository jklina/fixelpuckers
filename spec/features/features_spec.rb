require 'spec_helper'

describe "Features", type: :feature do
  let(:feature) { create(:feature) }

  describe "viewing a feature on the homepage" do
    it "let's us view the homepage if there are no features" do
      visit(root_path)
      expect(page).to have_content("Pixelfuckers")
    end

    it "displays the feature author and description on the homepage" do
      feature
      visit(root_path)
      expect(page).to have_content(feature.author.username)
      expect(page).to have_content(feature.description)
    end
  end

  describe "viewing a list of features" do
    it "lets any user view a list of submissions that were featured" do
      feature
      visit(features_path)
      expect(page).to have_content(feature.description)
      expect(page).to have_content(feature.author)
    end
  end
end
