ActiveAdmin.register Zone do

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
    render partial: 'action', locals: { element: f.object, key: Settings.google.maps.key }
    f.inputs 'Detalles' do
      f.input :name
    end
    f.inputs('Ubicación', class: 'geofence-fieldset') do
      # Coordindate selector anchor point
      f.input :lat, as: :geofence
    end
    f.actions
  end

end
