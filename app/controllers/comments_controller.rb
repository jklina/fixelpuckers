class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_comment, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.user = @user
    if @comment.save
      redirect_to @user, notice: 'Comment was successfully created.'
    else
      flash[:error] = 'Comment not saved.'
      render 'users/show'
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to @user, notice: 'Comment was successfully updated.'
    else
      render "users/show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @user
  end

  private

  def find_user
    @user = User.friendly.find(params[:user_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
