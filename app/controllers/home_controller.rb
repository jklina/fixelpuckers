class HomeController < ApplicationController
  def index
    @submissions = Submission.page(params[:page]).per(6)
  end
end
