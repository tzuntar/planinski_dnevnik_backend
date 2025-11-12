class AuthController < ApplicationController
  require "jwt"
  before_action :login_params, only: [ :login ]
  before_action :register_params, only: [ :register ]

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
    user = User.new(params)

    if user.save  # avtomatsko (poskusi) dodat nov entry, hasha password etc... (noro dobr!)
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: "Prišlo je do napake pri registraciji" }, status: :unprocessable_entity
    end

  end

  def refresh_token

  end

  private

  def login_params
    begin
      params.require([ :email, :password ])
    rescue ActionController::ParameterMissing
      render json: { error: "Missing required parameters" }, status: :unprocessable_content
    end
  end

  def register_params
    begin
      params.require([ :email, :password, :name ])
    rescue ActionController::ParameterMissing
      render json: { error: "Missing required parameters" }, status: :unprocessable_content
    end
  end
end
