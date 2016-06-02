class Api::AppUserMarkersController < Api::ApiController

  # filters
  before_filter :assert_user, only: [:sync]

  # GET /app_user_markers/:zone_id
  def list
    render json: cls.list_by_marker(params[:zone_id])
  end

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
