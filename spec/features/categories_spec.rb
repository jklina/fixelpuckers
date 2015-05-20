require 'spec_helper'

describe "Categories", type: :feature do
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }

  describe "viewing a list" do
    it "an admin can view all the categories" do
      category
      visit(admin_categories_path(as: admin.id))
      expect(page).to have_content(category.name)
    end
  end

  describe "viewing" do
    it "displays the categorys submissions" do
      sub1 = create(:submission, category: category)
      sub2 = create(:submission)
      visit(category_path(category))
      within(".featured") do
        expect(page).to have_content(category.name)
      end
      expect(page).to have_content(sub1.title)
    end
  end

  describe "editing" do
    before(:each) do
      visit(edit_admin_category_path(category, as: admin.id))
    end

    it "has the form filled out with the existing values" do
      expect(find_field('Name').value).to eq(category.name)
    end

    it "let's an admin update the category name" do
      fill_in("Name", with: "Screenshots")
      click_button("Update Category")
      category.reload
      expect(category.name).to eq("Screenshots")
      expect(current_path).to eq(admin_categories_path)
    end
  end

  describe "creating" do
    it "lets admins add new categories to the database" do
      visit(new_admin_category_path(as: admin.id))
      fill_in("Name", with: "Screenshots")
      click_button("Create Category")
      expect(Category.last.name).to eq("Screenshots")
      expect(current_path).to eq(admin_categories_path)
    end
  end
end
