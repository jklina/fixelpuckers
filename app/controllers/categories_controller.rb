class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @submissions = @category.submissions.page(params[:page]).per(6)
  end
end
