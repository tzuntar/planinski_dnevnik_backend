class UsersController < ApplicationController
  before_action :authorized

  def profile
    render json: { user: current_user }
  end

  def show

  end
end
