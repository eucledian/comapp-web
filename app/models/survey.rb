class Survey < ActiveRecord::Base

  # validations
  validates :name, length: { in: 2..100 }, presence: true

end
