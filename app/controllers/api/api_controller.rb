class Api::ApiController < ApplicationController

  # disable CSRF verification
  skip_before_action :verify_authenticity_token

  # show constant
  Show = 50

  # no layout
  layout false

  # attributes
  attr_accessor :app_session, :app_token

  protected

  # app session method
  # gets the authenticated user and refreshes the token
  # in the app_session variable if the request has a valid token
  # @return AppUser or nil
  # @raise ActiveRecord::RecordInvalid
  def app_session
    @app_session ||= ->{
      has_token? do
        token = Api::AppUserToken.find_auth_token(@token_data['Auth-Token'], @token_data['Auth-Secret'])
        if token.present?
          self.app_token = token
          user = token.app_user
          user
        end
      end
    }.call
  end

  # has token method
  # yieds if auth token and auth secret param
  # are available in the request headers
  def has_token?
    @token_data = self.request.headers
    yield if @token_data['Auth-Token'].present? && @token_data['Auth-Secret'].present?
  end

  def set_user
    has_token? do
      render_403 if app_session.nil?
    end
  end

  # assert methods
  def assert_user
    render_401 if app_session.nil?
  end

  def assert_fb_user
    render_401 if fb_user.nil?
  end

  # facebook methods
  def fb_user
    @fb_user ||= ->{
      Facebook::User.new(token: params[:token]) if params[:token].present?
    }.call
  end

  def facebook
    @facebook ||= ->{
      if fb_user.present?
        el = Api::AppUser.facebook
        el.user = fb_user
      end
    }.call
  end

  def recover_token
    @recover_token ||= AppUserToken.recover_token(params[:token], params[:secret])
  end

  def assert_recovery
    render_401 if self.recover_token.nil?
  end

end
