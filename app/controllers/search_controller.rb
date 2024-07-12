class SearchController < ApplicationController
  def index
    @query = params[:query]
    @category = params[:category]

    @results = case @category
               when 'music'
                 Music.where("title ILIKE ? OR description ILIKE ?", "%#{@query}%", "%#{@query}%")
               when 'artists'
                 Artist.joins(:user).where("users.name ILIKE ? OR bio ILIKE ?", "%#{@query}%", "%#{@query}%")
               when 'genres'
                 Genre.where("name ILIKE ?", "%#{@query}%")
               when 'comments'
                 Comment.where("body ILIKE ?", "%#{@query}%")
               else
                 Music.where("title ILIKE ? OR description ILIKE ?", "%#{@query}%", "%#{@query}%")
               end
  end
end
