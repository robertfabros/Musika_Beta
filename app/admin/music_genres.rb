ActiveAdmin.register MusicGenre do
  permit_params :music_id, :genre_id

  form do |f|
    f.inputs "MusicGenre Details" do
      f.input :music, as: :select, collection: Music.all.map { |m| [m.title, m.id] }, include_blank: false
      f.input :genre, as: :select, collection: Genre.all.map { |g| [g.name, g.id] }, include_blank: false
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :music do |mg|
      link_to mg.music.title, admin_music_path(mg.music)
    end
    column :genre do |mg|
      link_to mg.genre.name, admin_genre_path(mg.genre)
    end
    actions
  end

  show do
    attributes_table do
      row :music do |mg|
        link_to mg.music.title, admin_music_path(mg.music)
      end
      row :genre do |mg|
        link_to mg.genre.name, admin_genre_path(mg.genre)
      end
    end
    active_admin_comments
  end

  filter :music, as: :select, collection: Music.all.map { |m| [m.title, m.id] }
  filter :genre, as: :select, collection: Genre.all.map { |g| [g.name, g.id] }
  filter :created_at
  filter :updated_at
end
