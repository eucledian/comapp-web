FactoryGirl.define do

  sequence(:app_user_survey_response_response){ |n| "Response #{n}" }

  factory :app_user_survey_response, class: AppUserSurveyResponse do

    response { generate(:app_user_survey_response_response) }

    association :survey_field, factory: :survey_field
    association :app_user_survey, factory: :app_user_survey
  end
end
