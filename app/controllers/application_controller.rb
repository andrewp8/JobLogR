class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:landing_page, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :username, :first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :email, :password, :password_confirmation, :username, :first_name, :last_name])
  end

  private

  def authenticate_user!
    if !user_signed_in? || (user_signed_in? && current_user.provider != "google")
      super # Proceed with Devise authentication if the user is not signed in or if the user signed in with a method other than Google
    end
  end

  def landing_page?
    request.path == root_path
  end

  def after_sign_in_path_for(resource)
    boards_path
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
