# app/admin/pages.rb
ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  form do |f|
    f.inputs 'Page Details' do
      f.input :title
      f.input :content, as: :text
      f.input :slug, input_html: { readonly: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page|
        simple_format page.content
      end
      row :slug
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  controller do
    def find_resource
      scoped_collection.find_by_slug(params[:id])
    end
  end
end
