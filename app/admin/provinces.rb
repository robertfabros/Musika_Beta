ActiveAdmin.register Province do
  permit_params :name, :gst, :pst, :qst, :hst

  index do
    selectable_column
    id_column
    column :name
    column :gst
    column :pst
    column :qst
    column :hst
    column :created_at
    actions
  end

  filter :name
  filter :gst
  filter :pst
  filter :qst
  filter :hst
  filter :created_at

  form do |f|
    f.inputs "Province Details" do
      f.input :name
      f.input :gst
      f.input :pst
      f.input :qst
      f.input :hst
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :gst
      row :pst
      row :qst
      row :hst
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
