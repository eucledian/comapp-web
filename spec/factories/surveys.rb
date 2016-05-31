FactoryGirl.define do

  sequence(:survey_name) { |n| "Survey #{n}" }
  sequence(:survey_description) { |n| "Survey Description #{n}" }

  factory :survey, class: Survey do

    name { generate(:survey_name) }
    description { generate(:survey_description) }
    is_active true

    association :zone, factory: :zone
  end
end
