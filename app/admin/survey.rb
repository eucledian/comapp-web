ActiveAdmin.register Survey do

  # associations
  belongs_to :zone

  # strong parameters
  permit_params do
    permitted = :name, :is_active, :description
    permitted << :zone_id if params[:action] == 'create'
    permitted
  end

  # sidebar
  sidebar 'Detalles', only: [:show] do
    ul do
      li link_to I18n.t('active_admin.survey_fields.title'),
        admin_survey_survey_fields_path(survey)
    end
  end

  # form
  form do |f|
    f.inputs 'Detalles' do
      if f.object.new_record?
        f.input :zone_id, as: :hidden, input_html: { value: zone.id }
      end
      f.input :name
      f.input :is_active
      f.input :description
    end
    f.actions
  end

end
