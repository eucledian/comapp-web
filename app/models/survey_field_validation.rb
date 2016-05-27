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

  def self.identities
    ValidationIdentity.select_values
  end

  def self.json_data_types
    ValidationDataType.to_json.html_safe
  end

  def self.json_identities
    ValidationIdentity::List.to_json.html_safe
  end

end
