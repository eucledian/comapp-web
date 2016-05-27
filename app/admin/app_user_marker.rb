ActiveAdmin.register AppUserMarker do

  # associations
  belongs_to :app_user

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      #li link_to I18n.t('active_admin.survey_fields.title'),
        #admin_survey_survey_fields_path(survey)
    end
  end

end
