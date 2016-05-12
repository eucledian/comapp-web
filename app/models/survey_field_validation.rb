class SurveyFieldValidation < ActiveRecord::Base

  # associations
  belongs_to :survey_field

  # validations
  validates :identity, :option_value, :survey_field, presence: true
  validates :name, length: { in: 2..100 }

end
