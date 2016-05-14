class Marker < ActiveRecord::Base

  # validations
  validates :name, presence: true
  validates :name, length: { in: 2..100 }
  validates :extension, length: { in: 2..10 }, allow_nil: true

end
