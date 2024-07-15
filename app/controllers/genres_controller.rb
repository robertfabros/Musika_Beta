# app/controllers/genres_controller.rb
class GenresController < ApplicationController
  before_action :set_breadcrumbs, only: [:index, :show]

  def index
    @genres = Genre.all
    @breadcrumbs << content_tag(:li, 'Genres', class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  def show
    @genre = Genre.find(params[:id])
    @breadcrumbs << link_to('Genres', genres_path)
    @breadcrumbs << content_tag(:li, @genre.name, class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end
end
