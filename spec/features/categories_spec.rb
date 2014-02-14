require 'spec_helper'

describe "Categories" do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }

  describe "viewing" do
    it "an admin can view all the categories" do
      category
      visit(categories_path(as: user.id))
      expect(page).to have_content(category.name)
    end
  end
end
