class UsersController < Clearance::UsersController
  # before_action :set_user, only: [:show, :edit]

  def index
    @users = User.all
  end

  def show
    set_user
    @comment = @user.find_or_build_comment_from(current_user) if signed_in?
  end

  def edit
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user

    if @user.update(permit_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render action: :edit
    end
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

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def permit_params
    params.require(:user).permit(:username, :email, :password, :location, :domain, :avatar)
  end
end
