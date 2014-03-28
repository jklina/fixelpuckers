class Admin::FeaturesController < InheritedResources::Base
  before_action :authorize_feature

  def new
    @submission = Submission.friendly.find(params[:id])
    @feature = Feature.new(submission: @submission, author: current_user)
  end

  def create
    @feature = Feature.new(permitted_params[:feature])
    @feature.author = current_user
    if @feature.save
      redirect_to root_path, notice: 'Submission was successfully featured.'
    else
      render :new
    end
  end

  def update
    update! {root_path}
  end

  def destroy
    destroy! { features_path }
  end

  private

  def authorize_feature
    authorize Feature
  end

  def permitted_params
    params.permit(feature: [:description, :submission_id])
  end
end
