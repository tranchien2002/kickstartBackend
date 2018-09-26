class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user = User.find_by email: auth_params[:email]
    render json: {
      status: true
    }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
