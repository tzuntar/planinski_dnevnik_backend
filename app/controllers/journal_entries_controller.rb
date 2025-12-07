class JournalEntriesController < ApplicationController
  before_action :authorized
  before_action :journal_entry_params, only: [:create]

  def create
    peak = Peak.find_or_create_by!(name: params[:peak])
    @entry = JournalEntry.new(journal_entry_params)
    @entry.peak = peak

    if @entry.save
      render json: @entry
    else
      render json: { error: @entry.errors.messages }, status: :bad_request
    end
  end

  private

  def journal_entry_params
    params.permit(:name, :description, :peak, :user_id)
  end
end
