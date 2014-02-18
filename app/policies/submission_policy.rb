class SubmissionPolicy
  attr_reader :user, :submission

  def initialize(user, submission)
    @user = user
    @submission = submission
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    current_user_is_submission_author?
  end

  def trash?
    current_user_is_submission_author?
  end

  def update?
    current_user_is_submission_author?
  end

  private

  def current_user_is_submission_author?
    user == submission.author
  end
end
