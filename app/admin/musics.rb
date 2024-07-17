ActiveAdmin.register Music do
  permit_params :artist_id, :title, :price, :file, :description, :genre_id

  form do |f|
    f.inputs "Music Details" do
      f.input :artist, as: :select, collection: Artist.all.map { |a| [a.user.name, a.id] }, include_blank: false
      f.input :title
      f.input :genre, as: :select, collection: Genre.all.map { |g| [g.name, g.id] }, include_blank: false
      f.input :price
      f.input :file, as: :file
      f.input :description
    end
    f.actions
  end

  show do |music|
    attributes_table do
      row :artist
      row :title
      row :genre
      row :price
      row :file do
        if music.file.attached?
          link_to music.file.filename.to_s, rails_blob_path(music.file, disposition: "attachment")
        end
      end
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :artist
    column :title
    column :genre
    column :price
    column :file do |music|
      if music.file.attached?
        link_to music.file.filename.to_s, rails_blob_path(music.file, disposition: "attachment")
      end
    end
    column :created_at
    actions
  end

  filter :artist
  filter :title
  filter :genre, as: :select, collection: Genre.all.map { |genre| [genre.name, genre.id] }
  filter :price
  filter :created_at
end
