class AppUser < ActiveRecord::Base

  # concerns
  include Authenticable

  # associations
  has_many :app_user_surveys
  has_many :app_user_markers
  has_many :app_user_tokens, foreign_key: :user_id

  # scopes
  scope :filter_auth, ->(mail, password){ where(mail: mail, password: password) }
  scope :filter_by_mail, ->(mail){ where(mail: mail) }

  # validations
  validates :name, :last_names, :mail, :password, presence: true
  validates :name, length: { in: 2..100 }
  validates :last_names, length: { in: 2..100 }
  validates :mail, length: { in: 2..100 }

  before_validation :set_auth, on: :create

  # authenticate method
  # returns a token or errors hash
  # receives a +data+ hash
  # @return Hash - response formmatted token and errors
  def self.authenticate(data)
    data = {} if data.blank?
    pass = data[:password]
    pass = ApplicationController.encrypt(pass) unless pass.blank?
    el = self.filter_auth(data[:mail], pass).first
    token = nil
    errors = {}

    if el.present?
      token = el.serialize({})
      errors = el.errors
    end
    { token: token, errors: errors }
  end

  # returns the minimum length for the password to be validated via
  # +Authenticable+ concern.
  # @return Int - min pass length
  def min_pass_length
    @min_pass_length ||= 6
  end

  protected

  def set_auth
    set_password(password, password_confirmation)
  end

end
