module PlayStore
  class Item
    include ActiveModel::Model

    attr_accessor :platform, :country, :lang, :genre, :segment
    attr_accessor :id, :url, :title, :author, :price
    attr_accessor :image_url, :rating, :rating_count, :download_count

    MUTABLE_ATTRIBUTES =
      %i(title author price image_url rating rating_count download_count)

    def attributes
      {
        'platform' => platform,
        'country' => country,
        'lang' => lang,
        'genre' => genre,
        'segment' => segment,
        'id' => id,
        'url' => url,
        'title' => title,
        'author' => author,
        'price' => price,
        'image_url' => image_url,
        'rating' => rating,
        'rating_count' => rating_count,
        'download_count' => download_count
      }
    end

    def crawler
      @crawler ||= platform::Crawler.new.tap do |crawler|
        crawler.country = country
        crawler.lang = lang
        crawler.genre = genre
        crawler.segment = segment
      end
    end

    def update!
      item = crawler.find id
      MUTABLE_ATTRIBUTES.each do |k|
        if (v = item.send(k))
          send "#{k}=", v
        end
      end
      self
    end

    def reviews
      Enumerator.new do |y|
        crawler.load_reviews(id).each_with_index do |review, i|
          review.index = i + 1
          y << review
        end
      end
    end
  end
end
