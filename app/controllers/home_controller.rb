# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def index
    @featured_artists = Artist.includes(:user).limit(5)
    @genres = Genre.all
  end


end
