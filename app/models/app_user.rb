class AppUser < ActiveRecord::Base

  # associations
  has_many :app_user_surveys
  has_many :app_user_markers

  # validations
  validates :name, :last_names, :mail, :password, presence: true
  validates :name, length: { in: 2..100 }
  validates :last_names, length: { in: 2..100 }
  validates :mail, length: { in: 2..100 }

end
