class FeaturePolicy
  attr_reader :user

  def initialize(user, category)
    @user = user
  end

  def new?
    user_admin?
  end

  def create?
    user_admin?
  end

  def edit?
    user_admin?
  end

  def update?
    user_admin?
  end
  private

  def user_admin?
    user.admin?
  end
end
