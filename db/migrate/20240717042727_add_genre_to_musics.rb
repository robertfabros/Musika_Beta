class AddGenreToMusics < ActiveRecord::Migration[6.0]
  def change
    add_reference :musics, :genre, foreign_key: true
  end
end
