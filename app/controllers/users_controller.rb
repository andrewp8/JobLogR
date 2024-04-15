class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
      handle_avatar_upload
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = current_user
    puts "handle---- #{params[:user][:avatar].present?} "
    if @user.update(user_params)
      handle_avatar_upload
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def handle_avatar_upload
    if auth.present? && auth.info.image.present?
      avatar_url = auth.info.image
      downloaded_avatar = Down.download(avatar_url)
      @user.avatar.attach(io: downloaded_avatar, filename: "avatar.jpg")
    elsif params[:user][:avatar].present?
      @user.avatar.attach(params[:user][:avatar])
      puts "handle---- #{@user.avatar} "
    end
  end

  def auth
    request.env['omniauth.auth']
  end
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
