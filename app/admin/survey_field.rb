ActiveAdmin.register SurveyField do

  # associations
  belongs_to :survey

  # strong parameters
  permit_params do
    permitted = :name, :position, :data_type, :identity
    permitted << :survey_id if params[:action] == 'create'
    permitted
  end

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      li link_to I18n.t('active_admin.survey_field_options.title'),
        admin_survey_field_survey_field_options_path(survey_field)
      li link_to I18n.t('active_admin.survey_field_validations.title'),
        admin_survey_field_survey_field_validations_path(survey_field)
    end
  end

  # form
  form do |f|
    f.inputs 'Detalles' do
      if f.object.new_record?
        f.input :survey_id, as: :hidden, input_html: { value: survey.id }
      end
      f.input :name
      f.input :position
      f.input :data_type
      f.input :identity
    end
    f.actions
  end

end
