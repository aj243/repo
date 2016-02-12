class SessionsController < Devise::SessionsController

	# def create
 #    self.resource = warden.authenticate!(auth_options)
 #    flash[:notice] = "Signed in Sucessfully"
 #    sign_in(resource_name, resource)
 #    yield resource if block_given?
 #    respond_with resource, location: after_sign_in_path_for(resource)
 #  end

 #  def after_sign_in_path_for(resource)
 #    if resource.sign_in_count == 1
 #      edit_user_password_path
 #    else
 #      root_path
 #    end
 #  end

end