class Api::SurveysController < Api::ApiController

  # filters
  before_filter :assert_user

  # GET /surveys
  def list
    render json: {
      contents: cls.list.as_json(cls::Json::List)
    }
  end

  protected

  def cls
    @cls ||= Api::Zone
  end
end
