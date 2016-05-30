class AppUserToken < ActiveRecord::Base

  # concerns
  include Tokenable

  # possible values for +identity+ attribute
  module Identity
    Auth = 0
  end

  # scopes
  scope :filter_by_identity, ->(identity){ where(identity: identity) }

  # associations
  belongs_to :app_user, foreign_key: :user_id

  # validations
  validates :identity, presence: true

  # returns the Unix timestamp serialization of the +expires_at+ attribute if
  # present
  # @return Int - unix timestamp or nil
  def e_at
    @e_at ||= ->{
      self.expires_at.to_i unless self.expires_at.nil?
    }.call
  end

  # returns the expiry value for +expires_at+ attribute
  # @return [Time] - time value or nil
  def self.expiry
    # no expiry for MVP
    nil
  end

  # generates a new +AppUserToken+ based on +user_id+ and +identity+ attrs
  # +opts+ Hash maybe specified to overload +Tokenable#generate+ method
  # @param user_id [Int] - User +id+ atrribute
  # @param identity [Int] - AppUserToken +identity+ atrribute
  # @param opts [Hash] - optional additional attributes for model generation
  # @return +AppUserToken+ - generated instance
  def self.generate(user_id, identity, opts = {})
    args = { expires_at: self.expiry, identity: identity }.merge(opts)
    self.generate_token(user_id, args)
  end
end
