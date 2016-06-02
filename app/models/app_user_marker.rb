class AppUserMarker < ActiveRecord::Base

  # associations
  belongs_to :app_user
  belongs_to :zone
  belongs_to :marker

  # scopes
  scope :coordinate_base, ->{ select(:id, :lat, :lng) }
  scope :filter_by_marker_and_zone, ->(marker_id, zone_id){ where(marker_id: marker_id, zone_id: zone_id) }

  # validations
  validates :app_user, :zone, :marker, :lat, :lng, presence: true
  validates :lat, numericality: true
  validates :lng, numericality: true

end
