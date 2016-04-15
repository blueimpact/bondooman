class PublishJob < ActiveJob::Base
  queue_as :default

  def perform subscription
    formatter = subscription.formatter
    ranking = subscription.ranking_fetcher.rankings.newest
    item = subscription.item_fetcher.try(:items).try(:newest)

    subscription.publications.create!(
      body: formatter.format(ranking, [item])
    )
  end
end
