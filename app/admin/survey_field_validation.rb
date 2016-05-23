ActiveAdmin.register SurveyFieldValidation do

  # associations
  belongs_to :survey_field

  # strong parameters
  permit_params do
    permitted = :identity, :validation_args
    permitted << :survey_field_id if params[:action] == 'create'
    permitted
  end

  # form
  form do |f|
    f.inputs 'Detalles' do
      if f.object.new_record?
        f.input :survey_field_id, as: :hidden, input_html: { value: survey_field.id }
      end
      f.input :identity
      f.input :validation_args
    end
    f.actions
  end

end
