ActiveAdmin.register AppUser do

  # menu
  menu label: I18n.t('activerecord.models.app_user.one')

  # strong parameters
  permit_params :name, :last_names, :mail, :password, :password_confirmation

  index download_links: false do
    column :name
    column :last_names
    column :mail
    actions
  end

  # show
  show do
    attributes_table do
      row :id
      row :name
      row :last_names
      row :mail
    end
  end

  form do |f|
    f.inputs 'Usuario' do
      f.input :name
      f.input :last_names
      f.input :mail
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

end
