FactoryGirl.define do

  factory :app_user_survey, class: AppUserSurvey do

    association :survey, factory: :survey
    association :app_user, factory: :app_user
  end
end
