class Api::MarkersController < Api::ApiController

  # filters
  before_filter :assert_user

  # GET /markers
  def list
    render json: {
      contents: cls.list.as_json(cls::Json::List)
    }
  end

  protected

  def cls
    @cls ||= Api::Marker
  end
end
