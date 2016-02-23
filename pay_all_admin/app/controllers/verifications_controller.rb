class VerificationsController < ApplicationController
		before_action :set_user, only: [:new, :create, :verify]

		def new
			
		end

		def create
    @user.verification_code = Random.rand(1000..9999)
	  UserNotifier.send_otp_email(@user).deliver
	  # edit_user_registration_path
	  return
		end

	def verify
    if @user.verification_code == verification_params[:verification_code]
	    @user.is_verified = true
	    @user.verification_code = ''
	    @user.save
	    redirect_to user_session_path
  	else
    	new_user_verification_path(@user)
  	end
	end

	def email_verification_button
		return '' unless user.needs_email_verifying?
	end

	def verify_email_form
    return '' if user.verification_code.empty?
	end

	private
	def set_user
		@user = User.find_by(id: params[:user_id])
	end

	def verification_params
		params.require(:user).permit(:verification_code)
	end

end
