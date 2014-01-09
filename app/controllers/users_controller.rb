class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    if current_user.present?
      @comment = @user.find_or_build_comment_from(current_user)
    end
  end
end
