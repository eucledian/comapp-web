class Api::AppUserSurveyResponse < AppUserSurveyResponse

  def self.sync(survey_id, data, app_user)
    results = {}
    errors = {}
    survey = Survey.where(id: survey_id).first

    if survey.present?
      app_user_survey = AppUserSurvey.create(survey: survey, app_user: app_user)
      data.each do |key, response_data|
        local_errors = nil
        begin
          app_user_survey_response = AppUserSurveyResponse.new
          app_user_survey_response.app_user_survey = app_user_survey
          app_user_survey_response.survey_field = SurveyField.find(response_data[:survey_field_id])
          app_user_survey_response.response = response_data[:response]
          if app_user_survey_response.save
            results[key] = app_user_survey_response
          else
            local_errors = app_user_survey_response.errors
          end
        rescue Exception => e
          local_errors = e.to_s
        end
        errors[key] = local_errors if local_errors.present?
      end
    else
      errors[0] = 'Survey not found'
    end

    { results: results, errors: errors }
  end
end
