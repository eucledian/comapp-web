class Api::AppUserSurveyResponsesController < Api::ApiController

  # filters
  before_filter :assert_user

  # POST /surveys/3
  # params[app_user_survey_response][1][survey_field_id]
  def sync
    render json: cls.sync(params[:survey_id], data, app_session)
  end

  protected

  def cls
    @cls ||= Api::AppUserSurveyResponse
  end

  def data
    params[:app_user_survey_response] || {}
  end
end
