class SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      redirect_to edit_user_password_path
    else
      root_path
    end
  end

end