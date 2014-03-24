class Admin::FeaturesController < ApplicationController
  before_action :authorize_feature
  before_action :find_feature, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @feature.update_attributes(feature_params)
      redirect_to root_path, notice: 'Feature was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    if @feature.destroy
      redirect_to features_path, notice: 'Feature was successfully destroyed.'
    else
      redirect_to features_path, notice: 'Feature was not destroyed.'
    end
  end

  private

  def find_feature
    @feature = Feature.find(params[:id])
  end

  def authorize_feature
    authorize Feature
  end

  def feature_params
    params.require(:feature).permit(:description, :submission_id)
  end
end
