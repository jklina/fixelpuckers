class ApplicationController < ActionController::Base
  protect_from_forgery
  # check_authorization

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_path, :alert => exception.message
  # end

end
