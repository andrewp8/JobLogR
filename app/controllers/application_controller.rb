class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, except: [:landing, :about, :how_to_use]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :email, :password, :password_confirmation, :first_name, :last_name])
  end

  private

  # def landing_page?
  #   request.path == root_path
  # end

  def after_sign_in_path_for(resource)
    boards_path
  end

end
