class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :title
      t.references :genre, null: false, foreign_key: true
      t.decimal :price
      t.string :file_url
      t.text :description

      t.timestamps
    end
  end
end
