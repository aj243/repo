class UsersController < ApplicationController
	def index
    @users = User.all
  end
 
  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end
 
  def create
    @user = User.new(user_params)
 
    if @user.save
      redirect_to users_path, :notice => "Your new user was created!"
    else
      render 'new'
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end
 
  def update
    @user = User.find(params[:id])
 
    if @user.update_attributes(user_params)
       redirect_to users_path, :notice => "Your new user was updated!"
    else
      render 'edit'
    end

  end

   def show
    @user = User.find(params[:id])
  end
 
  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
     redirect_to users_path, :notice => "Your user was deleted!"
  end

end
