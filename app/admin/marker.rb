ActiveAdmin.register Marker do

  # strong parameters
  permit_params :name

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      #li link_to I18n.t('active_admin.survey_fields.title'),
        #admin_survey_survey_fields_path(survey)
    end
  end

  # form
  form do |f|
    f.inputs 'Detalles' do
      f.input :name
    end
    f.actions
  end

end
