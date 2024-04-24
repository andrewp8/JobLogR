class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, except: [:landing, :about, :how_to_use]
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :devise_controller? #login, signout, etc. are controller by devise_controller
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :email, :password, :password_confirmation, :first_name, :last_name])
  end

  private

  def after_sign_in_path_for(resource)
    boards_path
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
