class Api::BaseApi < ApplicationController
  def auth_header
    request.headers['Authorization']
  end

  def token
    auth_header.split(' ')[1]
  end

  def decoded_token
    if auth_header
      JsonWebToken.decode(token)
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { status: 'unauthorized', code: 401 }, status: :unauthorized unless logged_in?
  end

  def authenticate_cookie
    render json: { status: 'unauthorized', code: 401 }, status: :unauthorized unless logged_in?
  end
end
