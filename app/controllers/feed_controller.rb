class FeedController < ApplicationController
  before_action :authorized

  def get
    entries = JournalEntry.where("is_public = 1 AND user_id != ?", current_user.id)
      .includes(:user, :peak)
      .offset((params[:page] || 0) * (params[:limit] || 10))
      .limit(params[:limit] || 10)
    # Rails.logger.info entries.inspect
    render json: entries
  end
end
