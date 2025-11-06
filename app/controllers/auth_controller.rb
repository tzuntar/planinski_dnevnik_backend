class AuthController < ApplicationController
  require "jwt"
  before_action :login_params, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid e-mail or password" }, status: :unauthorized
    end
  end

  def register

  end

  def refresh_token

  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
