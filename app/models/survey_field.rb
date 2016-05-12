class SurveyField < ActiveRecord::Base

  # associations
  belongs_to :survey

  # validations
  validates :name, :survey, presence: true
  validates :name, length: { in: 2..100 }

end
