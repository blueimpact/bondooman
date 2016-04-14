class ItemFetchersController < FetchersController
  def model_class
    ItemFetcher
  end

  # GET /item_fetchers/1
  def show
    super
    @shots = @fetcher.shots.page
  end

  protected

  def fetcher_params
    params.require(:item_fetcher).permit(:platform, :item_code)
  end
end
