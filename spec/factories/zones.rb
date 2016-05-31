FactoryGirl.define do

  sequence(:zone_name) { |n| "Zone #{n}" }

  factory :zone, class: Zone do

    name { generate(:zone_name) }
    lat 19.20
    lng 10.20
  end
end
