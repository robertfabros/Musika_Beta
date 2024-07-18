class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  helper_method :breadcrumbs

  before_action :configure_permitted_parameters, if: :devise_controller?

  def breadcrumbs
    @breadcrumbs ||= []
    crumbs = [link_to('Home', root_path)]
    crumbs += @breadcrumbs
    crumbs.join(" / ").html_safe
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :province_id, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :province_id, :role])
  end
end
