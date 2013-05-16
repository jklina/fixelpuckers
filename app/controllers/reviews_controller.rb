require 'submissions'

class ReviewsController < ApplicationController
  load_and_authorize_resource :submission
  load_and_authorize_resource :review, through: :submission, except: :create

  def create
    @review = Review.new(params[:review])
    @review.user = current_user
    @review.submission = @submission
    if @review.save
      @submission.update_average_rating
      redirect_to @submission, notice: 'Review was successfully created.'
    else
      flash[:error] = 'Review not saved.'
      render 'submissions/show'
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      @submission.update_average_rating
      redirect_to @submission, notice: 'Review was successfully updated.'
    else
      render "submissions/show"
    end
  end

  def destroy
    @review.destroy
    @submission.update_average_rating
    redirect_to @submission
  end
end
