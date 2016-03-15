namespace :play_store do
  desc 'Crawl GooglePlay and AppStore'
  task crawl: :environment do
    jobs = [CrawlGooglePlayJob, CrawlAppStoreJob]
    genres = Genre.order(:id).all
    segments = Segment.order(:id).all
    jobs.product(genres, segments) do |job, genre, segment|
      job.perform_later genre, segment
    end
  end
end
