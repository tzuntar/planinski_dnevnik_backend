class UsersController < ApplicationController
  before_action :authorized

  # GET /profile
  def profile
    render json: { user: current_user }
  end

  def update_bio
    user = current_user
    
    if user.update(bio: params[:bio])
      render json: { message: "success", bio: user.bio }, status: :ok
    else
      render json: { error: "Napaka pri shranjevanju bio-ta" }, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    user = User.includes(:journal_entries).find(params[:id])
    render json: user.as_json.merge(
      posts: user.journal_entries
    )
  end
end
