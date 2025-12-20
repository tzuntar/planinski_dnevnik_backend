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

    ActiveRecord::Base.transaction do
      # --- for the country ---
      country_attribs = entry_attribs.dig("peak", "country")
      country =
        if country_attribs.present?
          Country.find_by(country_attribs) ||
            Country.create!(country_attribs)
        end

      # --- for the peak ---
      peak_attribs = entry_attribs["peak"].slice("name", "altitude")
      peak_attribs["country"] = country if country
      peak =
        Peak.find_by(peak_attribs) ||
        Peak.create!(peak_attribs)

      # --- for the photo --
      photo_path =
        if params[:photo].present?
          save_photo(params[:photo])
        end

      # --- final journal entry ---
      entry = JournalEntry.new(
        name: entry_attribs["name"],
        description: entry_attribs["description"],
        is_public: entry_attribs["is_public"],
        weather: entry_attribs["weather"],
        peak: peak,
        user: current_user,
        photo_path: photo_path
      )

      entry.save!

      render json: entry.as_json(
        include: {
          peak: {
            include: {
              country: { only: [:id, :name] }
            }
          }
        }
      ), status: :created

    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :bad_request
    rescue JSON::ParseError
      render json: { error: "Invalid JSON" }, status: :bad_request
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
