class ReviewPolicy
  attr_reader :user, :review

  def initialize(user, review)
    @user = user
    @review = review
  end

  def destroy?
    current_review_author_matches_current_user?
  end

  def edit?
    current_review_author_matches_current_user?
  end

  def update?
    current_review_author_matches_current_user?
  end

  private

  def current_review_author_matches_current_user?
    user == review.author
  end
end
