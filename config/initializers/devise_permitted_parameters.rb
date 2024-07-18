# config/initializers/devise_permitted_parameters.rb
module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :province_id, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :province_id, :role])
  end
end

Rails.application.config.to_prepare do
  Devise::RegistrationsController.send :include, DevisePermittedParameters
end
