class Survey < ActiveRecord::Base

  # associations
  belongs_to :zone
  has_many :survey_fields

  # validations
  validates :name, :zone, presence: true
  validates :name, length: { in: 2..100 }

end
