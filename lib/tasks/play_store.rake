namespace :play_store do
  desc 'Crawl GooglePlay and AppStore'
  task crawl: :environment do
    jobs = {
      googleplay: CrawlGooglePlayJob,
      appstore: CrawlAppStoreJob
    }
    RankingFetcher.find_each do |fetcher|
      job = jobs[fetcher.platform.to_sym]
      job.perform_later fetcher.genre, fetcher.segment
    end
  end
end
