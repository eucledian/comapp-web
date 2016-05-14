ActiveAdmin.register Zone do

  menu label: I18n.t('active_admin.zones.title')

  permit_params :name, :lat, :lng

  index download_links: false do
    id_column
    column :name
    column :lat
    column :lng
    actions
  end

  # show
  show do
     attributes_table do
       row :id
       row :name
       row :lat
       row :lng
     end
   end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :lat
      f.input :lng
    end
    f.actions
  end

end
