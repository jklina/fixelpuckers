require 'spec_helper'

describe "Categories" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:category) { FactoryGirl.create(:category) }

  describe "viewing" do
    it "an admin can view all the categories" do
      category
      visit(categories_path(as: admin.id))
      expect(page).to have_content(category.name)
    end
  end

  describe "editing" do
    before(:each) do
      visit(edit_category_path(category, as: admin.id))
    end

    it "has the form filled out with the existing values" do
      expect(find_field('Name').value).to eq(category.name)
    end

    it "let's an admin update the category name" do
      fill_in("Name", with: "Screenshots")
      click_button("Update Category")
      category.reload
      expect(category.name).to eq("Screenshots")
      expect(current_path).to eq(categories_path)
    end
  end
end
