class HomeController < ApplicationController
  def index
    @submissions = Submission.filtered_trash_for(current_user).
      page(params[:page]).per(6)
  end
end
