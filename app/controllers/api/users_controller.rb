module Api
  class Api::UsersController < Api::BaseApi
    def new
      begin
        login_hash = User.handle_login!(params[:email], params[:password])
        render json: { login_hash: login_hash }, status: :created
      rescue => e
        render json: { error: e }, status: :not_found
      else
      end
    end
  end
end