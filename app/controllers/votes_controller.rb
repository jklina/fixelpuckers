class VotesController < ApplicationController
  respond_to :json

  # before_filter :votable

  def up
    respond_with(votable.add_or_update_evaluation(:votes, 1, current_user),
                 location: nil)
  end

  def down
    respond_with(votable.add_or_update_evaluation(:votes, -1, current_user),
                 location: nil)
  end

  def destroy
    respond_with votable.delete_evaluation(:votes, current_user)
  end

  private

  def votable
    klass = params[:votable_type].constantize
    klass.find(params[:votable_id])
    # authorize! :read, @votable
  end
end
