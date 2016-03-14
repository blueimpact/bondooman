require 'mechanize'

module PlayStore
  module GooglePlay
    class Crawler < PlayStore::Crawler
      def agent
        @agent ||= Mechanize.new.tap do |agent|
          agent.user_agent_alias = 'Linux Mozilla'
          agent.request_headers['accept-language'] = lang.split('_').first
        end
      end

      def load_ranking
        count = 0
        Enumerator.new do |y|
          while count < config.item_count_max
            page = agent.post ranking_url, num: 100, ipf: 1, start: count
            break if page.search('.card[data-docid]').blank?
            parse_ranking_page(page).each do |item|
              count += 1
              y << item
            end
          end
        end
      end

      def find id
        url = "https://play.google.com/store/apps/details?id=#{id}"
        agent.get url
        e = agent.page.at('.main-content')

        create_item(
          id: id,
          url: url,
          title: e.at('.document-title').text.strip,
          author: e.at('.document-subtitle.primary').text.strip,
          price:
            e.at('[itemprop=price]')['content'].to_s.gsub(/^\D|,/, '').to_i,
          rating: e.at('.score').try(:text).to_s.delete(',').to_f,
          rating_count: e.at('.reviews-num').try(:text).to_s.delete(',').to_i
        ).tap do |item|
          if (img = e.at('[itemprop=image]')) && img['src'].present?
            item.image_url = URI.join(url, img['src']).to_s
          end
          if (n = e.at('[itemprop=numDownloads]'))
            item.download_count =
              n.text.to_s.delete(',').scan(/\d+/).map(&:to_i)
          end
        end
      end

      def load_reviews id
        url = 'https://play.google.com/store/getreviews'
        page = 1
        args = { reviewType: 0, id: id, reviewSortOrder: 4, xhr: 1 }
        Enumerator.new do |y|
          while page
            agent.transact do
              agent.post url, args.merge(pageNum: page)
              json = JSON.parse(agent.page.body.lines.drop(2).join).flatten
              page = (json[1].to_i == 1) ? page + 1 : nil
              doc = Nokogiri::HTML json.flatten[2]
              parse_reviews_page(doc).each do |review|
                y << review
              end
            end
            config.access_interval_proc.call
          end
        end
      end

      private

      def ranking_url
        @ranking_url ||=
          begin
            args = {}
            args[:category] = GENRES[genre] if GENRES[genre]
            args[:collection] = SEGMENTS[segment]
            q = args.to_query.gsub(/[&=]/, '/')
            "https://play.google.com/store/apps/#{q}"
          end
      end

      def parse_ranking_page page
        page.search('.card[data-docid]').map do |e|
          create_item(
            id: e['data-docid'],
            url: agent.page.uri.merge(e.at('a.title')['href']).to_s,
            title: e.at('a.title')['title'],
            author: e.at('a.subtitle')['title'],
            price: e.at('.display-price').try(:text).to_s.gsub(/^\D|,/, '').to_i
          )
        end
      end

      def parse_reviews_page page
        page.search('.single-review').map do |e|
          Review.new(
            title: e.at('.review-body .review-title').text.strip,
            body:
              e.at('.review-body').children.select(&:text?).map(&:text).join
              .strip,
            rating: e.at('.current-rating')['style'][/\d+/].to_i * 5 / 100,
            created_at: e.at('.review-date').text.split(/\D+/).join('-').to_date
          )
        end
      end
    end
  end
end
