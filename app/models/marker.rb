class Marker < ActiveRecord::Base

  # attachment
  has_attached_file :icon, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  # validations
  validates :name, length: { in: 2..100 }, presence: true

end
