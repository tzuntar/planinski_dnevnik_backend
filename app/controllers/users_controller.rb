class UsersController < ApplicationController
  before_action :authorized

  # GET /profile
  def profile
    photourl = get_full_url(current_user.photo_uri)
    
    render json: { 
      user: current_user.as_json.merge(photo_uri: photourl) 
    }
  end

  def update_avatar
    user = current_user

    if params[:avatar].present?
      path = save_photo(params[:avatar])
      
      if user.update(photo_uri: path)
        
        polni_url = "#{request.base_url}#{path}"
        
        render json: { 
          message: "Profilna slika uspešno posodobljena!", 
          photo_uri: polni_url 
        }, status: :ok
      else
        render json: { error: "Napaka pri shranjevanju." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Ni slike." }, status: :unprocessable_entity
    end
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
    
    full_photo_uri = get_full_url(user.photo_uri)

    render json: user.as_json.merge(
      photo_uri: full_photo_uri,
      posts: user.journal_entries
    )
  end

  def get_full_url(path)
    return nil unless path.present?
    "#{request.base_url}#{path}"
  end

  #kopirano iz journalentries controllerja
  def save_photo(uploaded_file)
    extension = File.extname(uploaded_file.original_filename)
    filename = "#{SecureRandom.uuid}#{extension}"

    upload_dir = Rails.root.join("public", "uploads")
    FileUtils.mkdir_p(upload_dir)
    full_path = upload_dir.join(filename)

    File.open(full_path, "wb") do |f|
      f.write(uploaded_file.read)
    end
    "/uploads/#{filename}"
  end
end
