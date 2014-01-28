class SubmissionsController < ApplicationController
  before_action :find_submission, only: [:show, :edit, :update, :destroy]

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
    @submission = Submission.new(submission_params)
    @submission.author = current_user
    if @submission.save
      redirect_to @submission, notice: 'Submission was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @submission.update_attributes(submission_params)
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

  def submission_params
    params.require(:submission).permit(:description, :title)
  end
end
