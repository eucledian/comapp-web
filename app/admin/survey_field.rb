ActiveAdmin.register SurveyField do

  # menu
  menu label: I18n.t('activerecord.models.survey_field.one')

  # associations
  belongs_to :survey

  #config.sort_order = 'position'
  sortable sorting_attribute: :position

  # strong parameters
  permit_params do
    permitted = :name, :data_type, :identity, :position
    permitted << :survey_id if params[:action] == 'create'
    permitted
  end

  index(download_links: false, as: :sortable) do |el|
    label :name
    #label :data_type
    #label :identity
    actions
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
      f.input :data_type, as: :select, collection: SurveyField.data_types
      f.input :identity, as: :select, collection: SurveyField.identities
    end
    f.actions
  end

end
