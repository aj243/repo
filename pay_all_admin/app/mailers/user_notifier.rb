class UserNotifier < ActionMailer::Base
  default :from => 'some_address@example.com'

  def send_signup_email(current_user)
    @user = current_user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up and Rest the password' )
  end

  def send_otp_email(current_user)
    @user = current_user
    mail( :to => @user.email,
    :subject => 'OTP' )
  end

end