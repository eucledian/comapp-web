ActiveAdmin.register Zone do

  # menu
  menu label: I18n.t('activerecord.models.zone.one')

  # strong parameters
  permit_params :name, :lat, :lng

  # index
  index download_links: false do
    column :name
    column :lat
    column :lng
    actions
  end

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      li link_to I18n.t('active_admin.surveys.title'),
        admin_zone_surveys_path(zone)
    end
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

   # form
  form do |f|
    f.inputs 'Detalles' do
      f.input :name
      f.input :lat
      f.input :lng
    end
    f.actions
  end

end
