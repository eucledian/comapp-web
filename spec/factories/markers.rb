FactoryGirl.define do

  sequence(:marker_name){ |n| "Marker #{n}" }
  sequence(:marker_icon_file_name){ |n| "marker#{n}.png" }

  factory :marker, class: Marker do

    name { generate(:marker_name) }
    icon_file_name { generate(:marker_icon_file_name) }
    icon_content_type 'image/png'
    icon_file_size 1024
  end
end
