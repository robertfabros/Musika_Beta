class AddNotNullConstraintToGenreIdInMusics < ActiveRecord::Migration[6.0]
  def change
    change_column_null :musics, :genre_id, false
  end
end
