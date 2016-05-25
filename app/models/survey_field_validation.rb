class SurveyFieldValidation < ActiveRecord::Base

  # concerns
  include Validatable

  # associations
  belongs_to :survey_field

  # validations
  validates :survey_field, presence: true
  validates :identity, inclusion: { in: ValidationIdentity.keys }
  validates :validation_args, length: { minimum: 2 }, allow_nil: true

  # methods
  def is_presence?
    self.identity == ValidationIdentity::Presence
  end

end
