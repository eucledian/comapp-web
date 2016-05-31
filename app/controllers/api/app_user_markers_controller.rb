class Api::AppUserMarkersController < Api::ApiController

  # filters
  before_filter :assert_user

  # POST /markers
  # params[app_user_marker][lat] ...
  def sync
    render json: cls.sync(data, app_session)
  end

  protected

  def cls
    @cls ||= Api::AppUserMarker
  end

  def data
    params[:app_user_marker] || {}
  end
end
