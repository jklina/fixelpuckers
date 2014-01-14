class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit
  protect_from_forgery
end
