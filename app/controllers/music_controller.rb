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

  def on_sale
    @musics = Music.on_sale.page(params[:page])
    render :index
  end

  def newly_added
    @musics = Music.where("created_at >= ?", 3.days.ago).page(params[:page])
    render :index
  end

  def recently_updated
    @musics = Music.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago).page(params[:page])
    render :index
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end

end
