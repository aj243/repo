class UsersController < ApplicationController
  after_action :verify_authorized
  before_action :authenticate_user!

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def verified_by_admin
    @user = User.find(params[:id])
    authorize @user
    if @user.is_verified = true
      @user.save
      redirect_to users_path, notice: "User Verified"
    else
      redirect_to users_path, notice: "User Not Verified"
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :is_verified)
  end

end

