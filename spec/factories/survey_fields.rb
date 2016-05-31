FactoryGirl.define do

  sequence(:survey_field_position) { |n| n }
  sequence(:survey_field_name){ |n| "Field #{n}" }

  factory :survey_field, class: SurveyField do

    position { generate(:survey_field_position) }
    data_type DataTypeable::DataType::String
    identity FieldIdentifiable::Identity::Text
    name { generate(:survey_field_name) }

    association :survey, factory: :survey
  end
end
