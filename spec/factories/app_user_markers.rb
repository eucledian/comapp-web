FactoryGirl.define do

  factory :app_user_marker, class: AppUserMarker do

    lat 19.99
    lng 10.20

    association :app_user, factory: :app_user
    association :zone, factory: :zone
    association :marker, factory: :marker
  end
end
