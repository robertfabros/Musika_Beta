# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :set_breadcrumbs, only: [:show]

  def show
    @page = Page.find_by_slug(params[:slug])
    @breadcrumbs << content_tag(:li, @page.title, class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  def registration_success
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end
end
