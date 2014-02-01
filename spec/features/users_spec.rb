require 'spec_helper'

feature "User management" do
  let(:user) { FactoryGirl.create(:user) }
  feature "viewing a user" do
    scenario "uses friendly urls" do
      expect(user.to_param).to eq(user.slug)
    end

    scenario "displays the user's username" do
      visit user_path(user)
      expect(page).to have_content(user.username)
    end

    scenario "displays the user's last three submissions" do
      submissions = FactoryGirl.create_list(:submission, 4, author: user)
      visit user_path(user)
      submissions.sort! { |a, b| b.created_at <=> a.created_at }
      submissions[0..2].each do |submission|
        expect(page).to have_content(submission.title)
      end
      expect(page).not_to have_content(submissions.last.title)
    end
  end

  feature "editing a users profile" do
    it "let's the current user edit their profile" do
      visit edit_user_path(user, as: user.id)
      fill_in("Location", with: "Philadelphia")
      fill_in("URL", with: "www.w.com")
      click_button("Update User")
      user.reload
      expect(user.location).to eq("Philadelphia")
      expect(user.url).to eq("www.w.com")
    end
  end
end
