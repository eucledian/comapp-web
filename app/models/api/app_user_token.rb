class Api::AppUserToken < AppUserToken

  # JSON serialization options for controllers +as_json+ rendering
  module Json
    List = {
      only: [:token, :secret],
      methods: [:e_at, :api_user]
    }
  end

  # modules
  module Expiry
    def self.mobile_auth
      nil
    end
  end

  def self.auth_token(user_id, data={})
    identity = Identity::Auth
    el = self.find_by_user(user_id, data.merge(identity: identity))
    if el.nil?
      el = self.generate(user_id, identity, data.merge(expires_at: Expiry.mobile_auth))
      el = nil unless el.save
    end
    el
  end

  def self.find_auth_token(token, secret)
    self.find_token(token, secret, identity: Identity::Auth)
  end

  def api_user
    @api_user ||= app_user.as_json(self.class.user_cls::Json::Show)
  end

  protected

  def self.user_cls
    @user_cls ||= Api::AppUser
  end
end
