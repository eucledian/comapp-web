ActiveAdmin.register SurveyFieldValidation do

  l_base = 'activerecord.models'

  # associations
  belongs_to :survey_field

  # breadcrumbs
  breadcrumb do
    survey = survey_field.survey
    zone = survey.zone
    crumbs = [
      link_to('Admin', admin_root_path),
      link_to(I18n.t("#{l_base}.zone.other"), admin_zones_path),
      link_to(zone.name, admin_zone_path(zone)),
      link_to(I18n.t("#{l_base}.survey.other"), admin_zone_surveys_path(zone)),
      link_to(survey.name, admin_zone_survey_path(zone, survey)),
      link_to(I18n.t("#{l_base}.survey_field.other"), admin_survey_survey_fields_path(survey)),
      link_to(survey_field.name, admin_survey_survey_field_path(survey, survey_field))
    ]
    begin # <method>.present? throws exception instead of nil within block
      crumbs <<
        link_to(I18n.t("#{l_base}.survey_field_validation.other"),
          admin_survey_field_survey_field_validations_path(survey_field)) if survey_field.present?
    rescue
    end
    crumbs
  end

  # strong parameters
  permit_params do
    permitted = [:identity, validation_args: SurveyFieldValidation::ValidationIdentity.param_keys]
    permitted << :survey_field_id if params[:action] == 'create'
    permitted
  end

  skip_before_action :verify_authenticity_token

  # form
  form do |f|
    render partial: 'action', locals: { form: f, klass: SurveyFieldValidation }
    f.inputs 'Detalles' do
      if f.object.new_record?
        f.input :survey_field_id, as: :hidden, input_html: { value: survey_field.id }
      end
      f.input :identity, as: :select, collection: SurveyFieldValidation.identities
    end
    f.actions
  end

end
