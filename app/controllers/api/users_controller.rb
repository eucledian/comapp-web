class Api::UsersController < ApplicationController

  # POST /api/users/login.json
  def login
    respond_to do |format|
      format.json do
        render json: cls.authenticate(data)
      end
    end
  end

  protected

  def cls
    @cls ||= Api::AppUser
  end

  def data
    params[:app_user]
  end
end
