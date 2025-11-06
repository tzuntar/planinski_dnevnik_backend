class UsersController < ApplicationController
  def profile
    render json: { user: current_user }
  end
end
