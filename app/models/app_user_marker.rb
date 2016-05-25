class AppUserMarker < ActiveRecord::Base

  # associations
  belongs_to :app_user
  belongs_to :zone
  belongs_to :marker

  # validations
  validates :app_user, :zone, :marker, :lat, :lng, presence: true
  validates :lat, numericality: true
  validates :lng, numericality: true

end
