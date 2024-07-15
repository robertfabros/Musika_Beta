# app/controllers/music_controller.rb
class MusicController < ApplicationController
  def index
    @musics = Music.page(params[:page]).per(15)
  end

  def show
    @music = Music.find(params[:id])
  end
end
