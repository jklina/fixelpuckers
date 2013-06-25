require 'spec_helper'

describe "viewing a user" do
  let(:user) { FactoryGirl.create(:user) }

  it "uses friendly urls" do
    expect(user.to_param).to eq(user.slug)
  end

  it "displays the user's username" do
    visit user_path(user)
    expect(page).to have_content(user.username)
  end

  it "displays the user's last three submissions" do
    submissions = FactoryGirl.create_list(:submission, 4, user: user)
    visit user_path(user)
    submissions.sort! { |a, b| b.created_at <=> a.created_at }
    submissions[0..2].each do |submission|
      expect(page).to have_content(submission.title)
    end
    expect(page).not_to have_content(submissions.last.title)
  end

  it_behaves_like 'a commentable page' do
    let(:commentable) { user }
    let(:commentable_path) { user_path(user) }
  end
end
