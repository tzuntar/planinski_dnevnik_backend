class FeedController < ApplicationController
  before_action :authorized

  def get
    entries = JournalEntry
      .includes(:user, :peak)
      .where("is_public = 1 AND user_id != ?", current_user.id)
      .offset((params[:page] || 0) * (params[:limit] || 10))
      .limit(params[:limit] || 10)
    render json: entries.as_json(
      include: {
        peak: {
          include: {
            country: { only: [:id, :name] }
          }
        },
        user: { only: [ :id, :name, :photo_path ] },
      }
    )
  end
end
