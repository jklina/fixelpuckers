require 'spec_helper'

describe "Comments" do
  let(:comment) { FactoryGirl.create(:comment, author: author, user: user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:user) }
  let(:paragraph) { Faker::Lorem.paragraph }

  describe "Viewing Comments" do
    it "shows author's comments on the user page" do
      visit user_path(comment.user)
      expect(page).to have_content(comment.body)
    end
  end


  describe "Submitting a comment" do
    context "when the author isn't a registered user" do
      before(:each) do
        visit user_path(user)
      end

      it "does not let an author place a comment on a user" do
        expect(page).not_to have_selector('form')
      end

      it "tells the an author to sign up to place a comment" do
        expect(page).to have_content("Please sign up to leave a comment.")
      end
    end

    context "when an author is a registered user" do
      before (:each) do
        visit user_path(user, as: author.id)
      end

      it "lets an author place a comment on a user" do
        expect(page).to have_selector('form#new_comment')
      end

      context "and a comment doesn't pass validation" do
        before(:each) { visit user_path(user, as: author.id) }

        it "flashs an error message" do
          click_button('Create Comment')
          within(:css, "#flash_error") do
            expect(page).to have_content('Comment not saved.')
          end
        end

        it "redirects the user to the user's show page" do
          expect(current_path).to eq(user_path(user))
        end
      end

      context "and a comment is created" do
        before(:each) do
          visit user_path(user)
          fill_in('comment[body]', with: paragraph)
          # click_button('Create Comment')
        end

        it "creates a new comment when one is filled out correctly" do
          expect { 
            click_button('Create Comment')
          }.to change(Comment, :count).by(1)
        end

        it "flashs a notice letting the user know the comment was created" do
          click_button('Create Comment')
          within(:css, "#flash_notice") do
            expect(page).to have_content('Comment was successfully created')
          end
        end

        it "redirects the user to the user's show page" do
          click_button('Create Comment')
          expect(current_path).to eq(user_path(user))
        end
      end

      context "and an existing comment is updated" do
        before(:each) do
          comment
          visit user_path(user, as: author.id)
        end

        it "has the comment form filled out with the existing comment" do
          expect(find_field('comment[body]').value).to eq(comment.body.to_s)
        end

        it "change the existing comment when the comment is updated"  do
          find("#comment_body").set("hello")
          click_button('Update Comment')
          comment.reload
          expect(comment.body).to eq('hello')
        end

        it "displays a message saying the comment has been updated" do
          click_button('Update Comment')
          within(:css, "#flash_notice") do
            expect(page).to have_content('Comment was successfully updated.')
          end
        end
      end
    end
  end
end

