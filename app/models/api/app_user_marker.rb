class Api::AppUserMarker < AppUserMarker

  def self.sync(data, app_user)
    results = {}
    errors = {}

    data.each do |key, marker_data|
      local_errors = nil
      begin
        app_user_marker = self.new
        app_user_marker.app_user = app_user
        app_user_marker.zone = Zone.find(marker_data[:zone_id])
        app_user_marker.marker = Marker.find(marker_data[:marker_id])
        app_user_marker.lat = marker_data[:lat]
        app_user_marker.lng = marker_data[:lng]
        if app_user_marker.save
          results[key] = app_user_marker
        else
          local_errors = app_user_marker.errors
        end
      rescue Exception => e
        local_errors = e.to_s
      end
      errors[key] = local_errors if local_errors.present?
    end

    { results: results, errors: errors }
  end
end
