FactoryGirl.define do

  factory :survey_field_validation, class: SurveyFieldValidation do

    identity Validatable::ValidationIdentity::Presence

    association :survey_field, factory: :survey_field
  end
end
