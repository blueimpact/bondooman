class FetchGooglePlayJob < ActiveJob::Base
  PLATFORM = :googleplay
  queue_as PLATFORM

  def perform item_code
    if (item = find_item_of_today(item_code))
      item_code.items.create!(
        item.attributes.merge(id: nil, ranking: nil, rank: nil)
      )
    else
      item_attributes =
        %w(url title author price image_url rating rating_count download_count)
      item = create_crawler.find(item_code.code)
      item_code.items.create!(
        item.attributes.slice(*item_attributes)
      )
    end
  end

  def find_item_of_today item_code
    item_code.items
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
      .order(created_at: :desc).first
    nil
  end

  private

  def create_crawler
    PlayStore::GooglePlay::Crawler.new.tap do |crawler|
      if ENV['TOKYO_PROXY'].present?
        uri = URI.parse ENV['TOKYO_PROXY']
        if uri.user && uri.password
          crawler.agent.set_proxy uri.host, uri.port, uri.user, uri.password
        else
          crawler.agent.set_proxy uri.host, uri.port
        end
      end
    end
  end
end
