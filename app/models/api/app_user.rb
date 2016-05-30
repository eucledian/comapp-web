class Api::AppUser < AppUser

  module Json
    List = {
      only: [:id, :name, :last_names, :mail]
    }
    Show = {
      only: [:id, :name, :last_names, :mail]
    }
  end

  def auth_token(data={})
    @auth_token ||= self.class.token_cls.auth_token(id, data)
  end

  def serialize(opts)
    token = auth_token(opts)
    unless token.nil?
      token.as_json(self.class.token_cls::Json::List)
    end
  end

  def self.filter(base, user)
    base.merge(exclude(user.id))
  end

  protected

  def self.token_cls
    @token_cls ||= Api::AppUserToken
  end
end
