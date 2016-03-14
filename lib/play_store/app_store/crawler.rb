require 'open-uri'

module PlayStore
  module AppStore
    class Crawler < PlayStore::Crawler
      def load_ranking
        args = { limit: config.item_count_max }
        args[:genre] = GENRES[genre] if GENRES[genre]
        q = args.to_query.gsub(/&/, '/')
        seg = SEGMENTS[segment]
        url = "https://itunes.apple.com/#{country}/rss/#{seg}/#{q}/xml"
        data = Nokogiri::XML(open(url))
        Enumerator.new do |y|
          data.css('feed entry').each do |e|
            y << create_item(
              id: e.at('id')['im:id'],
              url: e.at('id').text,
              title: e.at('im|name').text,
              author: e.at('im|artist').text,
              price: e.at('im|price')['amount'].to_i
            )
          end
        end
      end

      def find id
        url = "https://itunes.apple.com/lookup?id=#{id}&country=#{country}"
        json = JSON.parse open(url).read
        res = json['results'].first

        create_item(
          id: id,
          url: res['trackViewUrl'],
          title: res['trackName'],
          author: res['sellerName'],
          price: res['price'].to_i,
          image_url: res['artworkUrl100'],
          rating: res['averageUserRating'].to_f,
          rating_count: res['userRatingCount'].to_i
        )
      end

      def load_reviews id
        page = 1
        sortby = 'mosthelpful'
        Enumerator.new do |y|
          while page
            url = reviews_url(id, page, sortby)
            data = Nokogiri::XML(open(url))
            data.css('feed entry').to_a.drop(1).map do |e|
              y << Review.new(
                title: e.at('title').text,
                body: e.at('content').text,
                rating: e.at('im|rating').text.to_i,
                created_at: e.at('updated').text
              )
            end
            link = data.at('link[rel=last]')
            last_page = link && link['href'][/(?<=page=)\d+/].to_i
            page = (page < last_page) ? page + 1 : nil
            config.access_interval_proc.call
          end
        end
      end

      private

      def reviews_url id, page, sortby
        args = { id: id, page: page, sortby: sortby }
        q = args.to_query.gsub(/&/, '/')
        "https://itunes.apple.com/#{country}/rss/customerreviews/#{q}/xml"
      end
    end
  end
end
