 class RegistrationsController < Devise::RegistrationsController
	require 'securerandom'

	def create
		user = User.new(user_params)
		password = SecureRandom.urlsafe_base64(9)
		user.password = user.password_confirmation = password
		p password
		user.save
		UserNotifier.send_signup_email(user).deliver
		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:email, :name)
	end
end