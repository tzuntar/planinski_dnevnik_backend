class CountriesController < ApplicationController
  before_action :authorized

  def index
    render json: Country.all
  end
end
