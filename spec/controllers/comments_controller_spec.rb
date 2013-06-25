require 'spec_helper'

describe CommentsController do
  # I want to do integration testing here, but don't want to make a fake 
  # commentable model in the DB, so I'm just using a user model to represent 
  # commentable. I know this is bad, but am open to suggestions!

  let(:commentable) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:user) }
  let(:comment) do
      comment = commentable.comments.build(
        FactoryGirl.attributes_for(:comment)
      )
      comment.author = author
      comment.save!
      comment
  end
  let(:invalid_comment_attrs) {{ body: '' }}

  before(:each) do
    mock_all_abilities
  end

  describe "POST create" do
    let(:comment_attrs) { FactoryGirl.attributes_for(:comment) }

    describe "with valid params" do
      it "finds the commentable that will build the comment" do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        post :create, user_id: commentable,
             comment: comment_attrs,
             commentable_type: commentable.class.to_s
        expect(assigns(:commentable)).to eq(commentable)
      end

      it "creates a new Comment from the given user" do
        allow(controller).to receive(:current_user).and_return(author)
        expect {
          post :create, user_id: commentable,
               comment: comment_attrs,
               commentable_type: commentable.class.to_s
        }.to change(Comment, :count).by(1)
      end

      it 'assigns the comment user to the current user' do
        author = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user).and_return(author)
        post :create, user_id: commentable,
             comment: comment_attrs,
             commentable_type: commentable.class.to_s
        expect(assigns(:comment).author).to eq(author)
      end

      it "redirects to the user show page" do
        allow(controller).to receive(:current_user).and_return(author)
        post :create, user_id: commentable,
             comment: comment_attrs,
             commentable_type: commentable.class.to_s
        expect(response).to redirect_to(commentable)
      end
    end

    describe "with invalid params" do
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        request.env["HTTP_REFERER"] = "where_i_came_from"
        post :create, user_id: commentable,
             comment: invalid_comment_attrs,
             commentable_type: commentable.class.to_s
      end

      it "re-renders the 'new' template" do
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end

  describe "PUT update" do
    it "finds the user with the given id" do
      put :update, 
          user_id: comment.commentable,
          id: comment,
          commentable_type: comment.commentable.class.to_s
      expect(assigns(:commentable)).to eq(comment.commentable)
    end

    describe "with valid params" do
      it "updates the requested comment" do
        body = "Ipsum lorem"
        put :update,
            user_id: comment.commentable,
            id: comment,
            comment: { body: body },
            commentable_type: comment.commentable.class.to_s
        comment.reload
        expect(comment.body).to eq(body)
      end

      it "assigns the requested comment as @comment" do
        put :update,
            user_id: comment.commentable,
            id: comment,
            comment: FactoryGirl.attributes_for(:comment),
            commentable_type: comment.commentable.class.to_s
        expect(assigns(:comment)).to eq(comment)
      end

      it "redirects to the user show page" do
        put :update,
            user_id: comment.commentable,
            id: comment,
            comment: FactoryGirl.attributes_for(:comment),
            commentable_type: comment.commentable.class.to_s
        expect(response).to redirect_to(comment.commentable)
      end
    end

    describe "with invalid params" do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        put :update,
            user_id: comment.commentable,
            id: comment,
            comment: invalid_comment_attrs,
            commentable_type: comment.commentable.class.to_s
      end

      it "assigns the comment as @comment" do
        expect(assigns(:comment)).to eq(comment)
      end

      it "re-renders the 'edit' template" do
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end

  describe "DELETE destroy" do
    context "when the user owns the comment they're trying to delete" do
      it "destroys the requested comment" do
        comment
        expect {
          delete :destroy,
                 user_id: comment.commentable,
                 id: comment,
                 commentable_type: comment.commentable.class.to_s
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the comment's user" do
        comment
        delete :destroy,
               user_id: comment.commentable,
               id: comment,
               commentable_type: comment.commentable.class.to_s
        expect(response).to redirect_to(comment.commentable)
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
