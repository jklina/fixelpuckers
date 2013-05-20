class HomeController < ApplicationController
  def index
    @submissions = Submission.accessible_by(current_ability)
                              .page(params[:page])
                              .per(6)
  end
end
