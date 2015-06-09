require 'spec_helper'

feature "User management", type: :feature do
  let(:user) { create(:user) }
  feature "viewing a user" do
    scenario "uses friendly urls" do
      expect(user.to_param).to eq(user.slug)
    end

    scenario "displays the user's username" do
      visit user_path(user)
      expect(page).to have_content(user.username)
    end

    scenario "displays the user's last three submissions" do
      submissions = create_list(:submission, 4, author: user)
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
      fill_in("Domain", with: "w.com")
      attach_file "Avatar", "spec/assets/images/photo.jpg"
      click_button("Update User")
      user.reload
      expect(user.location).to eq("Philadelphia")
      expect(user.domain).to eq("w.com")
      expect(user.avatar.url).to include("photo.jpg")
    end
  end
end
