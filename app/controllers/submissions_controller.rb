class SubmissionsController < ApplicationController
  # load_and_authorize_resource
  before_filter :find_submission, only: [:show, :edit, :update, :destroy]

  def index
    @submissions = Submission.all
  end

  def show
    if current_user.present?
      @review = @submission.find_or_build_review_from(current_user)
    end
  end

  def new
    @submission = Submission.new
  end

  def edit
  end

  def create
    @submission = Submission.new(params[:submission])
    @submission.user = current_user
    if @submission.save
      redirect_to @submission, notice: 'Submission was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @submission.update_attributes(params[:submission])
      redirect_to @submission, notice: 'Submission was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_url
  end

  private

  def find_submission
    @submission = Submission.friendly.find(params[:id])
  end
end
