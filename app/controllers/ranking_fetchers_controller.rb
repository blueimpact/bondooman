class RankingFetchersController < FetchersController
  def model_class
    RankingFetcher
  end

  def fetcher_params
    params.require(:ranking_fetcher).permit(:platform, :genre_id, :segment_id)
  end
end
