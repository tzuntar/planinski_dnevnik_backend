class UsersController < ApplicationController
  before_action :authorized

  # GET /profile
  def profile
    render json: { user: current_user }
  end

  # GET /users/:id
  def show
    user = User.find_by(id: params[:id])
    render json: { user: user }
  end
end
