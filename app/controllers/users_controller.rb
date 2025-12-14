class UsersController < ApplicationController
  before_action :authorized

  # GET /profile
  def profile
    render json: { user: current_user }
  end

  # GET /users/:id
  def show
    user = User.includes(:journal_entries).find(params[:id])
    render json: user.as_json.merge(
      posts: user.journal_entries
    )
  end
end
