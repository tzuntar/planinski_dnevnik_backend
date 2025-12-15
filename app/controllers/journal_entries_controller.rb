class JournalEntriesController < ApplicationController
  before_action :authorized

  def index
    @entries = JournalEntry.where(user_id: current_user.id)
      .includes(:peak)
      .offset((params[:page] || 0) * (params[:limit] || 10))
      .limit(params[:limit] || 10)
    render json: @entries
  end

  def create
    # no touchie
    # noinspection RubyMismatchedArgumentType
    entry_attribs = JSON.parse(params[:journal_entry])
    peak = Peak.find_or_create_by!(name: entry_attribs["peak"])
    photo_path = save_photo(params[:photo]) if params[:photo].present?

    @entry = JournalEntry.new(
      name: entry_attribs["name"],
      description: entry_attribs["description"],
      is_public: entry_attribs["is_public"],
      peak: peak,
      user: current_user,
      photo_path: photo_path,
      weather: entry_attribs["weather"]
    )

    if @entry.save
      render json: @entry, status: :created
    else
      render json: { error: @entry.errors.full_messages }, status: :bad_request
    end
  end

  private

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
