class UsersController < ApplicationController
  after_action :verify_authorized
  before_action :authenticate_user!


  def index
    @users = User.all
    authorize User
  end

  def new
    @user = User.new
    authorize User
  end

  def create
    @user = User.new(user_params)
    @user.is_verified = true
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
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
          respond_to do |f|
            f.html { redirect_to user_url }
            f.js
        end  
    else
      redirect_to users_path, notice: "User Not Verified"
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    respond_to do |f|
      f.js { }
    end
  end

  def change_user_role
    authorize User
    user = User.find_by(id: params[:id])
    user.update(update_role_params)
    render nothing: true
  end

  private

  def secure_params
    params.require(:user).permit(:role, :is_verified, :password, :password_confrimation)
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :passord_confrimation, :is_verified)
  end

  def update_role_params
    params.require(:user).permit(:role)
  end
end

