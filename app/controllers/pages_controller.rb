# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:slug])
  end
end
