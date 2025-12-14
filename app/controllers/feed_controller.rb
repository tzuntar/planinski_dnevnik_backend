class FeedController < ApplicationController
  before_action :authorized

  def get
    entries = JournalEntry
      .includes(:user, :peak)
      .where("is_public = 1 AND user_id != ?", current_user.id)
      .offset((params[:page] || 0) * (params[:limit] || 10))
      .limit(params[:limit] || 10)
    # Rails.logger.info @entries.inspect
    render json: entries.as_json(
      includes: {
        user: { only: [ :id, :name, :photo_path ] },
        peak: { only: [ :id, :name ] }
      }
    )
  end
end
