# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @query = params[:query].to_s.downcase
    @category = params[:category]

    if @query.blank?
      @results = []
    else
      @results = case @category
                 when 'music'
                   Music.joins(artist: :user).joins(:genre).where("LOWER(musics.title) LIKE ? OR LOWER(musics.description) LIKE ? OR LOWER(genres.name) LIKE ? OR LOWER(users.name) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")
                 when 'artists'
                   Artist.joins(:user).where("LOWER(users.name) LIKE ? OR LOWER(artists.bio) LIKE ?", "%#{@query}%", "%#{@query}%")
                 when 'genres'
                   Genre.where("LOWER(name) LIKE ?", "%#{@query}%")
                 when 'comments'
                   defined?(Comment) ? Comment.where("LOWER(body) LIKE ?", "%#{@query}%") : []
                 else
                   Music.joins(artist: :user).joins(:genre).where("LOWER(musics.title) LIKE ? OR LOWER(musics.description) LIKE ? OR LOWER(genres.name) LIKE ? OR LOWER(users.name) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%") +
                   Artist.joins(:user).where("LOWER(users.name) LIKE ? OR LOWER(artists.bio) LIKE ?", "%#{@query}%", "%#{@query}%") +
                   Genre.where("LOWER(name) LIKE ?", "%#{@query}%") +
                   (defined?(Comment) ? Comment.where("LOWER(body) LIKE ?", "%#{@query}%") : [])
                 end
    end
  end
end
