class SurveyField < ActiveRecord::Base

  # concerns
  include DataTypeable # includes validation
  include FieldIdentifiable

  # associations
  belongs_to :survey
  has_many :survey_field_options
  has_many :survey_field_validations

  # position handling
  acts_as_list scope: :survey, top_of_list: 0

  # validations
  validates :name, :survey, presence: true
  validates :position, numericality: { only_integer: true }
  validates :identity, numericality: { only_integer: true }, inclusion: { in: Identity.keys }
  validates :name, length: { in: 2..100 }

  # methods
  def self.data_types
    DataType.select_values
  end

  def self.identities
    Identity.select_values
  end

end
