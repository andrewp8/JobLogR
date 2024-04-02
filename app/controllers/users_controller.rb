class UsersController < ApplicationController
  before_action :authenticate_user!

  def user_params
    params.require(:user).permit(:avatar, :email, :password, :password_confirmation)
  end
end
