require 'submissions'

class ReviewsController < ApplicationController
  before_filter :find_submission
  before_filter :find_review, except: [:create]
  # load_and_authorize_resource :submission
  # load_and_authorize_resource :review, through: :submission, except: :create

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

  private

  def find_submission
    @submission = Submission.friendly.find(params[:submission_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
