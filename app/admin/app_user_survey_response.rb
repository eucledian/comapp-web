ActiveAdmin.register AppUserSurveyResponse do

  # associations
  belongs_to :app_user_survey

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      #li link_to I18n.t('active_admin.survey_fields.title'),
        #admin_survey_survey_fields_path(survey)
    end
  end

end
