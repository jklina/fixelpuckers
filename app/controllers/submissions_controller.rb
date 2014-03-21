class SubmissionsController < ApplicationController
  before_action :find_submission, except: [:index, :new, :create]

  def show
    if signed_in?
      @review = @submission.find_or_build_review_from(current_user)
    end
    @submission.increment_views!
  end

  def new
    @submission = Submission.new
    authorize @submission
  end

  def edit
    authorize @submission
  end

  def trash
    authorize @submission
    if @submission.toggle_trash!
      redirect_to @submission, notice: "This submission is #{trashed_status}."
    else
      render :show
    end
  end

  def create
    @submission = Submission.new(submission_params)
    authorize @submission
    @submission.author = current_user
    if @submission.save
      redirect_to @submission, notice: 'Submission was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    authorize @submission
    if @submission.update_attributes(submission_params)
      redirect_to @submission, notice: 'Submission was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    authorize @submission
    @submission.destroy
    redirect_to submissions_path
  end

  private

  def find_submission
    @submission = Submission.filtered_trash_for(current_user).
                                               friendly.
                                               find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:description, :title, :category_id)
  end

  def trashed_status
    @submission.trashed ? "trashed" : "un-trashed"
  end
end
