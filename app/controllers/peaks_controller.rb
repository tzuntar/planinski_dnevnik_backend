class PeaksController < ApplicationController
  before_action :authorized

  def index
    render json: Peak.all
  end
end
