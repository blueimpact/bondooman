class RankingFetchersController < FetchersController
  def model_class
    RankingFetcher
  end

  # GET /ranking_fetchers/1
  def show
    super
    @rankings = @fetcher.rankings.includes(:genre, :segment).page
  end

  protected

  def fetcher_params
    params.require(:ranking_fetcher)
      .permit(:platform_name, :genre_id, :segment_id)
  end
end
