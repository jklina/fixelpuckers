class VotesController < ApplicationController
  respond_to :json

  before_filter :votable

  def vote_up
    respond_with(votable.add_or_update_evaluation(:votes, 1, current_user),
                 location: nil)
  end

  def vote_down
    respond_with(votable.add_or_update_evaluation(:votes, -1, current_user),
                 location: nil)
  end

  def remove_vote
    respond_with votable.delete_evaluation(:votes, current_user)
  end

  private

  def votable
    klass = params[:votable_type].constantize
    klass.find(params[:id])
    # authorize! :read, @votable
  end
end
