class Zone < ActiveRecord::Base

  validates :name, :lat, :lng, presence: true
  validates :name, length: { in: 2..200 }
  validates :lat, numericality: true
  validates :lng, numericality: true

end
