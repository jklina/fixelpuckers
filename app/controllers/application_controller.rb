class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :fetch_categories, :fetch_news_article


  def fetch_categories
    @browsable_categories = Category.all
  end

  def fetch_news_article
    @current_news_article = NewsArticle.last
  end

  def current_user
    super || Guest.new
  end

  private

  def user_not_authorized
    redirect_to(request.referrer || root_path)
  end
end
