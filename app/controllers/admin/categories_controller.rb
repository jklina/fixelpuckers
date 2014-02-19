class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update]

  def index
    authorize Category
    @categories = Category.all
  end

  def edit
    authorize @category
  end

  def new
    authorize Category
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to admin_categories_path,
        notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    authorize @category
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path,
        notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
