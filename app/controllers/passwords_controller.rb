class PasswordsController < Clearance::PasswordsController

  private

  def find_user_by_id_and_confirmation_token
    Clearance.configuration.user_model.
      find_by_slug_and_confirmation_token params[:user_id], params[:token].to_s
  end
end

