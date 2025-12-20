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
  # POST /change-password
  def change_password
    user = current_user

    if user.authenticate(params[:oldPassword])

      if (user.update(password: params[:newPassword]))
        render json: { message: "Geslo uspešno spremenjeno!" }, status: :ok
      else 
        render json: {error: "Geslo ne ustreza pogojem."}, status: :unprocessable_entity
      end

    else
      render json: { error: "Staro geslo je napačno." }, status: :unauthorized
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
