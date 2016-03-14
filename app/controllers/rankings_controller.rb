class RankingsController < ApplicationController
  before_action :set_ranking, only: [:show, :destroy]

  # GET /rankings
  def index
    @rankings = Ranking.page(params[:page])
  end

  # GET /rankings/1
  def show
  end

  # DELETE /rankings/1
  def destroy
    @ranking.destroy
    redirect_to rankings_url, notice: 'Ranking was successfully destroyed.'
  end

  private

  def set_ranking
    @ranking = Ranking.find(params[:id])
  end
end
