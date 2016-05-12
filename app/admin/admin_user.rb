ActiveAdmin.register AdminUser do

  menu label: I18n.t('active_admin.admin_users.title')

  permit_params :name, :last_names, :email, :password, :password_confirmation

  index download_links: false do
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  # show
  show do
     attributes_table do
       row :id
       row :name
       row :last_names
       row :email
       row :created_at
       row :updated_at
     end
   end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :last_names
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
