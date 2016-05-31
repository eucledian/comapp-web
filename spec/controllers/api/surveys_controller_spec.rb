describe Api::SurveysController do

  describe 'REST actions' do

    context 'GET list' do

      before do
        create_api_session
      end

      let!(:zone){ create(:zone) }
      let!(:survey){
        create(:survey,
          zone: zone
        )
      }
      let!(:survey_field){
        create(:survey_field,
          survey: survey
        )
      }
      let!(:survey_field_option){
        create(:survey_field_option,
          survey_field: survey_field
        )
      }
      let!(:survey_field_validation){
        create(:survey_field_validation,
          survey_field: survey_field
        )
      }

      let!(:url){
        api_surveys_list_url
      }
      let!(:params){ {} }

      it 'should retrieve a list of Survey instances' do
        with_rack_test_driver_api_session do
          page.driver.submit :get, url, params
        end

        response = JSON.parse(page.body)
        contents = response['contents']

        expect(contents.length).to eq(1)
        # zone expectations
        zone_data = contents.first
        expect(zone_data['id']).to eq(zone.id)
        expect(zone_data['name']).to eq(zone.name)
        expect(zone_data['lat']).to eq(zone.lat)
        expect(zone_data['lng']).to eq(zone.lng)

        # survey expectations
        survey_data = zone_data['surveys'].first
        expect(survey_data['id']).to eq(survey.id)
        expect(survey_data['zone_id']).to eq(survey.zone_id)
        expect(survey_data['is_active']).to eq(survey.is_active)
        expect(survey_data['name']).to eq(survey.name)
        expect(survey_data['description']).to eq(survey.description)

        # survey_field expectations
        survey_field_data = survey_data['survey_fields'].first
        expect(survey_field_data['id']).to eq(survey_field.id)
        expect(survey_field_data['survey_id']).to eq(survey_field.survey_id)
        expect(survey_field_data['position']).to eq(survey_field.position)
        expect(survey_field_data['data_type']).to eq(survey_field.data_type)
        expect(survey_field_data['identity']).to eq(survey_field.identity)
        expect(survey_field_data['name']).to eq(survey_field.name)

        # survey_field_option expectations
        survey_field_option_data = survey_field_data['survey_field_options'].first
        expect(survey_field_option_data['id']).to eq(survey_field_option.id)
        expect(survey_field_option_data['survey_field_id']).to eq(survey_field_option.survey_field_id)
        expect(survey_field_option_data['option_value']).to eq(survey_field_option.option_value)

        # survey_field_validation expectations
        survey_field_validation_data = survey_field_data['survey_field_validations'].first
        expect(survey_field_validation_data['id']).to eq(survey_field_validation.id)
        expect(survey_field_validation_data['survey_field_id']).to eq(survey_field_validation.survey_field_id)
        expect(survey_field_validation_data['identity']).to eq(survey_field_validation.identity)
        expect(survey_field_validation_data['validation_args']).to eq(survey_field_validation.validation_args)
      end
    end
  end
end
