class CreateMusicGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :music_genres do |t|
      t.references :music, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
