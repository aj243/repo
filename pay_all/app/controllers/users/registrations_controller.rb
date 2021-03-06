class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_verify, only: [:edit]

# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(user_params)
    @user.verification_code = Random.rand(1000..9999)
    @user.is_verified = false
    if @user.save
      UserNotifier.send_signup_email(@user).deliver
      redirect_to new_user_verification_path(@user.id)
    else
      render 'new'
    end
    # redirect_to url_for(:controller => :verification, :action => :new)
    
    # redirect_to root_path
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :name , :email, :password, :passord_confrimation)}
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :passord_confrimation)
  end

  def check_verify
    if user_signed_in? and ! current_user.is_verified
      redirect_to new_user_verification_path(current_user)
    end 
  end
  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
