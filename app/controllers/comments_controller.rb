class CommentsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :comment, through: :user, except: :create

  def create
    @comment = Comment.new(params[:comment])
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
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @user, notice: 'Comment was successfully updated.'
    else
      render "users/show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @user
  end
end
