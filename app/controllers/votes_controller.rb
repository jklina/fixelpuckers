class VotesController < ApplicationController
  before_filter :find_votable_instance

  def up
    if current_user.voted_up_on? @votable_instance
      @votable_instance.unliked_by current_user
    else
      @votable_instance.liked_by current_user
    end
    respond_to do |format|
      format.js {}
    end
  end

  def down
    if current_user.voted_down_on? @votable_instance
      @votable_instance.undisliked_by current_user
    else
      @votable_instance.disliked_by current_user
    end
    respond_to do |format|
      format.js {}
    end
  end

  private

  def find_votable_instance
    votable_klass = params[:type].classify.constantize
    @votable_instance = votable_klass.find(params[:id])
  end
end
