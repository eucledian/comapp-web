class AppUserSurvey < ActiveRecord::Base

  # associations
  belongs_to :app_user
  belongs_to :survey
  has_many :app_user_survey_responses

  # validations
  validates :app_user, :survey, presence: true

end
