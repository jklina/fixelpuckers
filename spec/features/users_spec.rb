require 'spec_helper'

describe "Viewing a user's page" do
  it "uses friendly urls" do
    user = FactoryGirl.create(:user)
    expect(user.to_param).to eq(user.slug)
  end

  it "displays the user's username" do
    user = FactoryGirl.create(:user)
    visit user_path(user)
    expect(page).to have_content(user.username)
  end
end
