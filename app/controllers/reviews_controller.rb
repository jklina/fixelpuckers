require 'submissions'

class ReviewsController < ApplicationController
  before_action :find_submission
  before_action :find_review, except: [:create]

  def create
    @review = Review.new(review_params)
    @review.author = current_user
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
    authorize @review
    if @review.update(review_params)
      @submission.update_average_rating
      redirect_to @submission, notice: 'Review was successfully updated.'
    else
      render "submissions/show"
    end
  end

  def destroy
    authorize @review
    @review.destroy
    @submission.update_average_rating
    respond_to do |format|
      format.js {}
      format.html { redirect_to @submission }
    end
  end

  private

  def find_submission
    @submission = Submission.friendly.find(params[:submission_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
