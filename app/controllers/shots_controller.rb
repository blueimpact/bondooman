class ShotsController < ApplicationController
  before_action :set_shot, only: [:show]

  # GET /shots
  def index
    @shots = Shot.all
  end

  # GET /shots/1
  def show
  end

  private

  def set_shot
    @shot = Shot.find(params[:id])
  end
end
