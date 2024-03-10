class TradelinesController < ApplicationController
  before_action -> { find_tradeline(params[:id]) }, only: %i[show]

  def index
    render json: {tradelines: Tradeline.all}
  end

  def show
    render json: {tradeline: @tradeline}
  end
end
