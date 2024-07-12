ActiveAdmin.register Artist do
  permit_params :user_id, :bio, :profile_picture

  form do |f|
    f.inputs "Artist Details" do
      f.input :user, as: :select, collection: User.where(role: :artist).map { |u| [u.name, u.id] }, include_blank: false
      f.input :bio
      f.input :profile_picture, as: :file
    end
    f.actions
  end

  show do |artist|
    attributes_table do
      row :user
      row :bio
      row :profile_picture do
        if artist.profile_picture.attached?
          image_tag url_for(artist.profile_picture), size: "200x200"
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :user
    column :bio
    column :created_at
    actions
  end

  filter :user
  filter :bio
  filter :created_at
end
