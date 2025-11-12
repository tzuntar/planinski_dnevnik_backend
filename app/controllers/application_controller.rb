class ApplicationController < ActionController::API

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base, "HS256")
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    return nil unless auth_header
    token = auth_header.split(" ").last
    begin
      JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    head :unauthorized unless logged_in?
  end
end
