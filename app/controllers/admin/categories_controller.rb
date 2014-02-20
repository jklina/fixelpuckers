class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update]
  before_action :authorize_category

  def index
    @categories = Category.all
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path,
        notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path,
        notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def authorize_category
    authorize Category
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
