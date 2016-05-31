describe Api::AppUserMarkersController do

  describe 'REST actions' do

    context 'POST sync' do

      before do
        create_api_session
      end

      let!(:marker){ create(:marker) }
      let!(:zone){ create(:zone) }
      let!(:valid_markers){
        3.times.map {
          build(:app_user_marker,
            zone: zone,
            marker: marker
          )
        }
      }

      let!(:url){
        api_app_user_markers_sync_url
      }
      let!(:params){ {} }

      def append_app_user_markers(app_user_markers)
        i = 0
        params[:app_user_marker] = {}
        app_user_markers.each do |app_user_marker|
          param_object = params[:app_user_marker][i] = {}
          param_object[:zone_id] = app_user_marker.zone_id
          param_object[:marker_id] = app_user_marker.marker_id
          param_object[:lat] = app_user_marker.lat
          param_object[:lng] = app_user_marker.lng
          i = i + 1
        end
      end

      it 'should create valid AppUserMarkers with valid params' do
        append_app_user_markers(valid_markers)

        with_rack_test_driver_api_session do
          page.driver.submit :post, url, params
        end

        response = JSON.parse(page.body)

        expect(response['results'].length).to equal(3)
        expect(response['errors']).to be_empty
      end

      it 'should create valid AppUserMarkers with valid & invalid params' do
        append_app_user_markers(
          valid_markers + [
            # invalid zone
            build(:app_user_marker,
              zone_id: 'INVALID'
            ),
            # invalid marker
            build(:app_user_marker,
              marker_id: 'INVALID'
            ),
            # invalid data
            build(:app_user_marker,
              lat: nil,
              lng: nil
            )
          ]
        )

        with_rack_test_driver_api_session do
          page.driver.submit :post, url, params
        end

        response = JSON.parse(page.body)

        expect(response['results'].length).to equal(3)
        expect(response['errors'].length).to equal(3)
      end
    end
  end
end
