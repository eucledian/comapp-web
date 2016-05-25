class Survey < ActiveRecord::Base

  # associations
  belongs_to :zone
  has_many :survey_fields

  # helper associations
  has_many :survey_field_options, through: :survey_fields
  has_many :survey_field_validations, through: :survey_fields

  # validations
  validates :name, :zone, presence: true
  validates :name, length: { in: 2..100 }

end
