class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    Rails.logger.debug "Sign in params: #{sign_in_params.inspect}"
    user = User.find_by(email: sign_in_params[:email])
    if user&.valid_password?(sign_in_params[:password])
      sign_in(user)
      redirect_to after_sign_in_path_for(user), notice: 'Signed in successfully'
    else
      flash[:alert] = 'Invalid email or password'
      redirect_to new_session_path(resource_name)
    end
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
  end
end
