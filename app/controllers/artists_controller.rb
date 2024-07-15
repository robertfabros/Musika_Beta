# app/controllers/artists_controller.rb
class ArtistsController < ApplicationController
  before_action :set_breadcrumbs, only: [:index, :show]

  def index
    @artists = Artist.all
    @breadcrumbs << content_tag(:li, 'Artists', class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  def show
    @artist = Artist.find(params[:id])
    @user = @artist.user
    @breadcrumbs << link_to('Artists', artists_path)
    @breadcrumbs << content_tag(:li, @artist.user.name, class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end
end
