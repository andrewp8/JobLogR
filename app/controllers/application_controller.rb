class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :landing_page?

  private

  def landing_page?
    request.path == root_path
  end
  # skip_forgery_protection
end
