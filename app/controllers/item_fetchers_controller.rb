class ItemFetchersController < FetchersController
  def model_class
    ItemFetcher
  end

  def fetcher_params
    params.require(:item_fetcher).permit(:platform, :item_code)
  end
end
