FactoryGirl.define do

  sequence(:app_user_mail) { |n| "test#{n}@example.com" }
  sequence(:app_user_name) { |n| "App User #{n}" }

  factory :app_user, class: AppUser do

    transient do
      raw_password '123456'
    end

    name { generate(:app_user_name) }
    last_names 'Last Name'
    mail { generate(:app_user_mail) }

    before(:create) do |app_user, evaluator|
      raw_password = evaluator.raw_password
      if raw_password.present?
        app_user.set_password raw_password, raw_password
      end
    end
  end
end
