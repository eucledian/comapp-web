ActiveAdmin.register Marker do

  # menu
  menu label: I18n.t('activerecord.models.marker.one')

  # strong parameters
  permit_params :name, :icon

  # form
  form do |f|
    f.inputs 'Detalles' do
      f.input :name
      f.input :icon, as: :file, required: true
    end
    f.actions
  end

end
