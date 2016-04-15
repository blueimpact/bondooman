class ItemFetchersController < FetchersController
  def model_class
    ItemFetcher
  end

  # GET /item_fetchers/1
  def show
    super
    @items = @fetcher.items.page
  end

  protected

  def fetcher_params
    params.require(:item_fetcher)
      .permit(:platform_name, :item_code_code)
  end
end
