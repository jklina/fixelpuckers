require 'spec_helper'

describe "Admin Page" do
  let(:admin) { FactoryGirl.create(:admin) }

  it "has a sub nav with admin functions" do
    visit(admin_path(as: admin.id))
    expect(page).to have_selector("#admin-nav")
  end
end
