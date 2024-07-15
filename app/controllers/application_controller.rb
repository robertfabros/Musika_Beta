# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
    crumbs = [link_to('Home', root_path)]
    crumbs += @breadcrumbs
    crumbs.join(" / ").html_safe
  end
end
