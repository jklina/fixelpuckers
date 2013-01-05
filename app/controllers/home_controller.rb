class HomeController < ApplicationController
  def index
    @submissions = Submission.accessible_by(current_ability)
  end
end
