class SurveyFieldOption < ActiveRecord::Base

  # associations
  belongs_to :survey_field

  # scopes
  scope :filter_by_option_value, ->(option_value){ where('survey_field_options.option_value = ?', option_value) }

  # validations
  validates :name, :option_value, :survey_field, presence: true
  validates :name, length: { minimum: 2 }
  validates :option_value, length: { minimum: 1 }

end
