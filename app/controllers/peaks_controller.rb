class PeaksController < ApplicationController
  before_action :authorized

  def index
    render json: Peak.all
  end

  def show
    @entries = JournalEntry.where(peak_id: params[:id])
                           .includes(:user)
                           .offset((params[:page] || 0) * (params[:limit] || 10))
                           .limit(params[:limit] || 10)
    render json: @entries.as_json(
      include: {
        user: {}
      }
    )
  end
end
