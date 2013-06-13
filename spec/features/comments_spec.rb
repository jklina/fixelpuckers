require 'spec_helper'

describe "GET 'users/show'" do

  it "shows author's comments on the user page" do
    comment = FactoryGirl.create(:comment)
    visit user_path(comment.user)
    expect(page).to have_content(comment.body)
  end

  context "when the user isn't signed in" do
    it "doesn't show the user comment form" do
      user = FactoryGirl.create(:user)
      visit user_path(user)
      expect(page).not_to have_selector('#author-comment form')
    end

    it "invites the user to signup" do
      user = FactoryGirl.create(:user)
      visit user_path(user)
      expect(page).to have_content('Signup to leave a comment')
    end
  end

  context "when the user is signed in" do
    before(:each) do
      create_logged_in_user
      user = FactoryGirl.create(:user)
      visit user_path(user)
    end

    it "shows the user comment form" do
      expect(page).to have_selector('#author-comment form')
    end

    context "and a comment doesn't pass validation" do
      it "flashs an error message" do
        click_button('Comment')
        within(:css, "#flash_error") do
          expect(page).to have_content('Comment not saved.')
        end
      end
    end

  end
end
