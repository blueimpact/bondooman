namespace :play_store do
  desc 'Crawl GooglePlay and AppStore'
  task crawl: :environment do
    jobs = {
      googleplay: CrawlGooglePlayJob,
      appstore: CrawlAppStoreJob
    }
    RankingFetcher.includes(:genre, :segment).find_each do |fetcher|
      job = jobs[fetcher.platform.to_sym]
      job.perform_later fetcher.genre, fetcher.segment
    end
  end

  desc 'Fetch registerd items'
  task fetch: :environment do
    jobs = {
      googleplay: FetchGooglePlayJob
    }
    ItemFetcher.includes(:item_code).find_each do |fetcher|
      job = jobs[fetcher.platform.to_sym]
      job.perform_later fetcher.item_code
    end
  end
end
