# app/admin/musics.rb
ActiveAdmin.register Music do
  permit_params :artist_id, :title, :genre_id, :price, :file, :description

  form do |f|
    f.inputs "Music Details" do
      f.input :artist
      f.input :title
      f.input :genre
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
          link_to music.file.filename, rails_blob_path(music.file, disposition: "attachment")
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
    column :created_at
    actions
  end
end
