class UserPolicy
  attr_reader :user, :requested_user

  def initialize(user, requested_user)
    @user = user
    @requested_user = requested_user
  end

  def edit?
    current_user_matches_requested_user?
  end

  def update?
    current_user_matches_requested_user?
  end

  private

  def current_user_matches_requested_user?
    user == requested_user
  end
end
