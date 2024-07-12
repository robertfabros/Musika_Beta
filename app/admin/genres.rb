# app/admin/genres.rb
ActiveAdmin.register Genre do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  filter :name
  filter :created_at
  filter :updated_at
end
