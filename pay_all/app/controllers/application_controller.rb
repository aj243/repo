class ApplicationController < ActionController::Base

	include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	# before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :check_verify, unless: :devise_controller?

	protected

		def check_verify
      if user_signed_in? and current_user.is_verified == false
        redirect_to new_verification_path
      end 
    end

    def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:password,:is_verified,:email, :verification_code) }
  	end

	  def user_not_authorized
	    flash[:alert] = "Access denied."
	    redirect_to (request.referrer || root_path)
	  end



		# def configure_permitted_parameters
		# 	#devise_parameters_sanitizer.permit(:sign_up) << :name
		# 	devise_parameter_sanitizer.for(:sign_up) << :name
		# 	devise_parameter_sanitizer.for(:account_update) << :name
		# end


  
end
