class UsersController < ApplicationController
  before_action :authenticate_user!

  # Controller action where you want to remove the avatar
  def remove_avatar
    @user = current_user
    
    # Remove the avatar
    @user.avatar.purge

    if @user.save
      flash[:success] = "Avatar removed successfully."
    else
      flash[:error] = "Failed to remove avatar."
    end

    redirect_to edit_user_registration_path
  end

  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
