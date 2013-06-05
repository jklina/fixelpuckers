class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user.present?
      @comment = @user.find_or_build_comment_from(current_user)
    end
  end

end
