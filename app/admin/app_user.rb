ActiveAdmin.register AppUser do

  # menu
  menu label: I18n.t('activerecord.models.app_user.one')

  # strong parameters
  # permit_params :name, :last_names, :mail

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      #li link_to I18n.t('active_admin.survey_fields.title'),
        #admin_survey_survey_fields_path(survey)
    end
  end

end
