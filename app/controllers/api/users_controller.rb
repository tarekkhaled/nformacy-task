module Api
  class Api::UsersController < Api::BaseApi
    def create
      begin
        data = User.handle_login!(params[:email], params[:password])
        render json: { data: data }, status: :created
      rescue => e
        render json: { error: e }, status: :not_found
      else
      end
    end
  end
end