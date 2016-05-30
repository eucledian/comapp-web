class ApplicationController < ActionController::Base

  # concerns
  include Controllable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
