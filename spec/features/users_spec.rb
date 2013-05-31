require 'spec_helper'

describe "viewing a user" do
  it "uses friendly urls" do
    user = FactoryGirl.create(:user)
    expect(user.to_param).to eq(user.slug)
  end

  it "displays the user's username" do
    user = FactoryGirl.create(:user)
    visit user_path(user)
    expect(page).to have_content(user.username)
  end

  it "displays the user's last three submissions" do
    user = FactoryGirl.create(:user)
    submissions = FactoryGirl.create_list(:submission, 4, user: user)
    visit user_path(user)
    submissions.sort! { |a, b| b.created_at <=> a.created_at }
    submissions[0..2].each do |submission|
      expect(page).to have_content(submission.title)
    end
    expect(page).not_to have_content(submissions.last.title)
  end
end
