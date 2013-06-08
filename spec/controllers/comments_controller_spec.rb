require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:user) }
  let(:invalid_comment_attrs) {{ body: '' }}

  before(:each) do
    mock_all_abilities
  end

  describe "POST create" do
    let(:comment_attrs) { FactoryGirl.attributes_for(:comment) }

    describe "with valid params" do
      it "finds the user that will build the comment" do
        post :create, user_id: user, comment: comment_attrs
        expect(assigns(:user)).to eq(user)
      end

      it "creates a new Comment from the given user" do
        allow(controller).to receive(:current_user).and_return(author)
        expect {
          post :create, user_id: user, comment: comment_attrs
        }.to change(Comment, :count).by(1)
      end

      it 'assigns the comment user to the current user' do
        author = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user).and_return(author)
        post :create, user_id: user, comment: comment_attrs
        expect(assigns(:comment).author).to eq(author)
      end

      it "redirects to the user show page" do
        allow(controller).to receive(:current_user).and_return(author)
        post :create, user_id: user, comment: comment_attrs
        expect(response).to redirect_to(user)
      end
    end

    describe "with invalid params" do
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        put :create, user_id: user, comment: invalid_comment_attrs
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("users/show")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @comment = FactoryGirl.create(:comment)
    end

    it "finds the user with the given id" do
      put :update, { user_id: @comment.user, id: @comment}
      expect(assigns(:user)).to eq(@comment.user)
    end

    describe "with valid params" do
      it "updates the requested comment" do
        body = "Ipsum lorem"
        put :update, { user_id: @comment.user, id: @comment,
                       comment: { body: body } }
        @comment.reload
        expect(@comment.body).to eq(body)
      end

      it "assigns the requested comment as @comment" do
        put :update, { user_id: @comment.user,
                       id: @comment,
                       comment: FactoryGirl.attributes_for(:comment) }
        expect(assigns(:comment)).to eq(@comment)
      end

      it "redirects to the user show page" do
        put :update, { user_id: @comment.user,
                       id: @comment,
                       comment: FactoryGirl.attributes_for(:comment) }
        expect(response).to redirect_to(@comment.user)
      end
    end

    describe "with invalid params" do
      before(:each) do
        put :update, { user_id: @comment.user,
                       id: @comment,
                       comment: invalid_comment_attrs }
      end

      it "assigns the comment as @comment" do
        expect(assigns(:comment)).to eq(@comment)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("users/show")
      end
    end
  end

  describe "DELETE destroy" do
    context "when the user owns the comment they're trying to delete" do
      before(:each) do
        @comment = FactoryGirl.create(:comment)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, {user_id: @comment.user, id: @comment}
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the comment's user" do
        delete :destroy, {user_id: @comment.user, id: @comment}
        expect(response).to redirect_to(@comment.user)
      end
    end

    # context "when the user doesn't own the comment they're trying to delete" do
    #   it "should not let them delete the comment" do
    #     user = FactoryGirl.create(:user)
    #     comment = FactoryGirl.create(:comment)
    #     user.comments << comment
    #     # controller.stub(:current_user).and_return(user)
    #   end
    # end
  end

end
