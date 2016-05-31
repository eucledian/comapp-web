FactoryGirl.define do

  sequence(:survey_field_option_name) { |n| "Survey Field Option #{n}" }

  factory :survey_field_option, class: SurveyFieldOption do

    name{ generate(:survey_field_option_name) }
    option_value 'VALUE'

    association :survey_field, factory: :survey_field
  end
end
