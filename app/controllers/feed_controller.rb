class FeedController < ApplicationController
  before_action :authorized

  def get
    JournalEntry.where("is_public = 1 AND user_id != ?", current_user.id)
                .includes(:users, :peaks)
                .offset((params[:page] || 0) * (params[:limit] || 10))
                .limit(params[:limit] || 10)
                .map do |entry|
      {
        user_name: entry.user.name,
        **rest
      }
    end
  end
end
