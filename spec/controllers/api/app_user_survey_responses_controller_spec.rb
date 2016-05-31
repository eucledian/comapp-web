describe Api::AppUserSurveyResponsesController do

  describe 'REST actions' do

    context 'POST sync' do

      before do
        create_api_session
      end

      let!(:survey){ create(:survey) }
      let!(:survey_field){
        create(:survey_field,
          survey: survey
        )
      }

      let!(:app_user_survey_responses){
        [
          build(:app_user_survey_response,
            response: '{"json": "input"}',
            survey_field_id: survey_field.id
          ),
          build(:app_user_survey_response,
            response: 'TEXT',
            survey_field_id: survey_field.id
          ),
          build(:app_user_survey_response,
            response: 'Option 10',
            survey_field_id: survey_field.id
          )
        ]
      }


      let!(:url){
        api_app_user_survey_responses_sync_url(survey_id: survey.id)
      }
      let!(:params){ {} }

      def apppend_app_user_survey_responses(app_user_survey_responses)
        i = 0
        params[:app_user_survey_response] = {}
        app_user_survey_responses.each do |app_user_survey_response|
          param_object = params[:app_user_survey_response][i] = {}
          param_object[:survey_field_id] = app_user_survey_response.survey_field_id
          param_object[:response] = app_user_survey_response.response
          i = i + 1
        end
      end

      it 'should create an AppUserSurvey with valid responses' do
        apppend_app_user_survey_responses(app_user_survey_responses)

        with_rack_test_driver_api_session do
          page.driver.submit :post, url, params
        end

        response = JSON.parse(page.body)

        expect(response['results'].length).to equal(3)
        expect(response['errors']).to be_empty
      end

      it 'should create an AppUserSurvey with valid and invalid responses' do
        apppend_app_user_survey_responses(
          app_user_survey_responses + [
            # invalid +survey_field_id+
            build(:app_user_survey_response,
              response: 'Option 10',
              survey_field_id: 'INVALID'
            ),
            # invalid response
            build(:app_user_survey_response,
              response: '',
              survey_field_id: survey_field.id
            )
          ]
        )

        with_rack_test_driver_api_session do
          page.driver.submit :post, url, params
        end

        response = JSON.parse(page.body)

        expect(response['results'].length).to equal(3)
        expect(response['errors'].length).to equal(2)
      end
    end
  end
end
