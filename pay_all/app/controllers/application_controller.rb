class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :set_user, only: [:check_verify]
  
	# before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :check_verify, unless: :devise_controller?
	

	protected

		def check_verify()
      if @user.is_verified == false
        redirect_to verify_user_verifications_path(@user)
      end 
    end

    def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:password,:is_verified,:email, :verification_code) }
  	end

  	def set_user
			@user = User.find_by(id: params[:user_id])
		end

		def verification_params
			params.require(:user).permit(:is_verified)
		end


		# def configure_permitted_parameters
		# 	#devise_parameters_sanitizer.permit(:sign_up) << :name
		# 	devise_parameter_sanitizer.for(:sign_up) << :name
		# 	devise_parameter_sanitizer.for(:account_update) << :name
		# end
  
end
