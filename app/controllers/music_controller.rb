# app/controllers/music_controller.rb
class MusicController < ApplicationController
  before_action :set_breadcrumbs, only: [:index, :show]

  def index
    @musics = Music.page(params[:page]).per(15)
    @breadcrumbs << content_tag(:li, 'Music', class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  def show
    @music = Music.find(params[:id])
    @breadcrumbs << link_to('Music', music_index_path)
    @breadcrumbs << content_tag(:li, @music.title, class: 'breadcrumb-item active', aria: { current: 'page' })
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end
end
