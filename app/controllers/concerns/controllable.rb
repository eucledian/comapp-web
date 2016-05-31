module Controllable

  extend ActiveSupport::Concern

  module ClassMethods
    def encrypt(*args)
      require 'digest/sha2'
      args.push Settings.salt
      Digest::SHA256.hexdigest(args.join)
    end
  end

  protected

  def render_js
    render "#{params[:action]}.js" and return
  end

  def base_url
    @base_url ||= "#{request.protocol}#{request.host_with_port}"
  end

  def render_401
    render_error(:unauthorized, "401 Unauthorized")
  end

  def render_403
    render_error(:forbbiden, "403 Forbbiden")
  end

  def render_404
    render_error(:not_found, "404 Not Found")
  end

  def render_error(status, message = nil)
    message = message.nil? ? "Error" : message
    render text: message, status: status
  end
end
