class Admin::CategoriesController < InheritedResources::Base
  before_action :authorize_category

  actions :index, :edit, :new, :create, :update

  private

  def authorize_category
    authorize Category
  end

  def resource
    @category ||= Category.friendly.find(params[:id])
  end

  def permitted_params
    params.permit(category: [:name])
  end
end
