module PlayStore
  class Item
    include ActiveModel::Model

    attr_accessor :platform, :country, :lang, :genre, :segment
    attr_accessor :id, :url, :title, :author, :price
    attr_accessor :image_url, :rating, :rating_count, :download_count

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
  end
end
