class AppUserSurveyResponse < ActiveRecord::Base

  # associations
  belongs_to :app_user_survey
  belongs_to :survey_field

  # validations
  validates :app_user_survey, :survey_field, presence: true
  validates :response, length: { minimum: 2 }

end
