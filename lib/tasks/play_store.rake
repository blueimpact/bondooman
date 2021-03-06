namespace :play_store do
  desc 'Crawl GooglePlay and AppStore'
  task crawl: :environment do
    jobs = {
      googleplay: CrawlGooglePlayJob,
      appstore: CrawlAppStoreJob
    }
    RankingFetcher.includes(:genre, :segment).find_each do |fetcher|
      job = jobs[fetcher.platform_name.to_sym]
      job.perform_later fetcher
    end
    Rake::Task['play_store:touch'].invoke
  end

  desc 'Fetch registerd items'
  task fetch: :environment do
    jobs = {
      googleplay: FetchGooglePlayJob
    }
    ItemFetcher.includes(:item_code).find_each do |fetcher|
      job = jobs[fetcher.platform_name.to_sym]
      job.perform_later fetcher
    end
    Rake::Task['play_store:touch'].invoke
  end

  desc 'Make publications for all subscriptions'
  task publish: :environment do
    Subscription.find_each do |subscription|
      PublishJob.perform_later subscription
    end
    Rake::Task['play_store:touch'].invoke
  end

  task :touch do
    if (url = ENV['TOUCH_URL'])
      sh 'curl', url
    end
  end
end

