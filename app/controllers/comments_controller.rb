class CommentsController < ApplicationController
  before_filter :get_commentable

  def create
    @comment = Comment.new(params[:comment])
    @comment.author = current_user
    @comment.commentable = @commentable
    authorize! :create, @comment

    if @comment.save
      redirect_to @commentable, notice: 'Comment was successfully created.'
    else
      flash[:error] = 'Comment not saved.'
      redirect_to :back
    end
  end

  def update
    @comment = Comment.find(params[:id])
    authorize! :update, @comment
    if @comment.update_attributes(params[:comment])
      redirect_to @commentable, notice: 'Comment was successfully updated.'
    else
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to @commentable
  end

  private

  def get_commentable
    klass = params[:commentable_type].constantize
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
    authorize! :read, @commentable
  end
end
