class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit
  protect_from_forgery
  before_action :fetch_categories

  def fetch_categories
    @browsable_categories = Category.all
  end
end
