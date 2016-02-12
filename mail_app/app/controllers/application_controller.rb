class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      edit_user_registration_path
    else
      root_path
    end
  end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) << :name
			devise_parameter_sanitizer.for(:account_update) << :name
		end

end
