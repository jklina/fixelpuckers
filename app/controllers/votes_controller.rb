class VotesController < ApplicationController
  before_filter :find_votable_instance

  def up
    @votable_instance.liked_by current_user
  end

  def down
    @votable_instance.disliked_by current_user
  end

  private

  def find_votable_instance
    votable_klass = params[:type].classify.constantize
    @votable_instance = votable_klass.find(params[:id])
  end
end
