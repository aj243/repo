module VerificationsHelper
	
		def email_verification_button
		return '' unless user.needs_email_verifying?
		html = <<-HTML
      <h3>Verify Account</h3>
      #{form_tag(verifications_path, method: "post")}
      #{button_tag('Send verification code', type: "submit")}
      </form>
    HTML
    html.html_safe
	end

	def verify_email_form
    return '' if user.verification_code.empty?
    p user.verification_code.empty?
    html = <<-HTML
      <h3>Enter Verification Code</h3>
      #{form_tag(verify_path, method: "post")}
      #{text_field_tag('verification_code')}
      #{button_tag('Submit', type: "submit")}
      </form>
    HTML
    html.html_safe
  end

end
