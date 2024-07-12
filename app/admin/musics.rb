ActiveAdmin.register Music do
  permit_params :artist_id, :title, :price, :file, :description, genre_ids: []

  form do |f|
    f.inputs "Music Details" do
      f.input :artist
      f.input :title
      f.input :genres, as: :check_boxes, collection: Genre.all
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
      row :genres do
        music.genres.map(&:name).join(", ")
      end
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
    column :genres do |music|
      music.genres.map(&:name).join(", ")
    end
    column :price
    column :created_at
    actions
  end

  filter :artist
  filter :title
  filter :genres, as: :select, collection: Genre.all.map { |genre| [genre.name, genre.id] }
  filter :price
  filter :created_at
end
