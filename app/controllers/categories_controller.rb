class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @submissions = @category.submissions.
      filtered_trash_for(current_user).
      page(params[:page]).per(6)
  end
end
