class SurveyField < ActiveRecord::Base

  # associations
  belongs_to :survey
  has_many :survey_field_options
  has_many :survey_field_validations

  # validations
  validates :name, :survey, presence: true
  validates :position, numericality: { only_integer: true }
  validates :data_type, numericality: { only_integer: true }
  validates :identity, numericality: { only_integer: true }
  validates :name, length: { in: 2..100 }

end
