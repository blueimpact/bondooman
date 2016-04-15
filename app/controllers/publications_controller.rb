class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_publication, only: [:show]

  # GET /publications
  def index
    @publications =
      current_user.publications
      .includes(
        subscription: [
          :formatter,
          { ranking_fetcher: [:genre, :segment] },
          { item_fetcher: [:item_code] }
        ])
      .new_first.page(params[:page])
  end

  # GET /publications/1
  def show
  end

  private

  def set_publication
    @publication = current_user.publications.find(params[:id])
  end
end
