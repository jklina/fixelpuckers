class Admin::FeaturesController < ApplicationController
  before_action :authorize_feature

  def new
    @submission = Submission.friendly.find(params[:id])
    @feature = Feature.new(submission: @submission, author: current_user)
  end

  def create
    @feature = Feature.new(feature_params)
    @feature.author = current_user
    if @feature.save
      redirect_to root_path, notice: 'Submission was successfully featured.'
    else
      render action: "new"
    end
  end

  private

  def authorize_feature
    authorize Feature
  end

  def feature_params
    params.require(:feature).permit(:description, :submission_id)
  end
end
