class Survey < ActiveRecord::Base

  belongs_to :zone

  # validations
  validates :name, :zone, presence: true
  validates :name, length: { in: 2..100 }

end
