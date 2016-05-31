describe Api::MarkersController do

  describe 'REST actions' do

    context 'GET list' do

      before do
        create_api_session
      end

      let!(:marker){ create(:marker) }

      let!(:url){
        api_markers_list_url
      }
      let!(:params){ {} }

      it 'should retrieve a list of Marker instances' do
        with_rack_test_driver_api_session do
          page.driver.submit :get, url, params
        end

        response = JSON.parse(page.body)
        contents = response['contents']
        content = contents.first

        expect(contents).not_to be_empty
        expect(content['id']).to eq(marker.id)
        expect(content['name']).to eq(marker.name)
        expect(content['icon_url']).to be_present
      end
    end
  end
end
