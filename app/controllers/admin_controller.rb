class AdminController < ApplicationController
  def index
    authorize :admin_dashboard, :index?
  end
end
