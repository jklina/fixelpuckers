class UsersController < Clearance::UsersController

  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    @comment = @user.find_or_build_comment_from(current_user) if signed_in?
  end

  private

  def user_from_params
    user_params = permit_params || Hash.new
    username = user_params.delete(:username)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.username = username
      user.email = email
      user.password = password
    end
  end

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end
end
