class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if resource.persisted?
        sign_out resource
        redirect_to registration_success_path and return
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    registration_success_path # This might not be needed if we handle redirection in create
  end
end
