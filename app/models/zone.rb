class Zone < ActiveRecord::Base

  # relationships
  has_many :surveys

  # validations
  validates :name, :lat, :lng, presence: true
  validates :name, length: { in: 2..200 }
  validates :lat, numericality: true
  validates :lng, numericality: true

  def self.select_list
    order(name: :asc)
  end

end
