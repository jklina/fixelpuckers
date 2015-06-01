require 'spec_helper'

describe "Admin Page", type: :feature do
  let(:admin) { create(:admin) }

  it "has a sub nav with admin functions" do
    visit(admin_path(as: admin.id))

    expect(page).to have_selector("#admin-nav")
  end

  it "can be accessed by an admin" do
    visit(root_path(as: admin.id))

    expect(page).to have_content(I18n.t('home.index.menu.admin'))
  end

  it "cannot be accesed by a non admin" do
    normal_user = create(:user)

    visit(root_path(as: normal_user.id))

    expect(page).to_not have_content(I18n.t('home.index.menu.admin'))
  end
end
