class CategoryPolicy
  attr_reader :user

  def initialize(user, category)
    @user = user
  end

  def index?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
