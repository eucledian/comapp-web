class Api::UsersController < Api::ApiController

  # POST /api/users/login
  def login
    render json: cls.authenticate(data)
  end

  protected

  def cls
    @cls ||= Api::AppUser
  end

  def data
    params[:app_user] || {}
  end
end
