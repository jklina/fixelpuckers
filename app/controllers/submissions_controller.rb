class SubmissionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    if current_user.present?
      @review = @submission.find_or_build_review_from(current_user)
    end
  end

  def new
  end

  def edit
  end

  def create
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
end
