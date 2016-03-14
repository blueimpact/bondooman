require 'play_store/item'

module PlayStore
  class Crawler
    include ActiveModel::Model

    attr_accessor :country, :lang
    attr_accessor :genre, :segment

    delegate :config, to: ::PlayStore

    def initialize *args
      self.country = config.country
      self.lang = config.lang
      super
    end

    def platform
      self.class.parent
    end

    def item_attributes
      {
        platform: platform,
        country: country,
        lang: lang,
        genre: genre,
        segment: segment
      }
    end

    def create_item attrs = {}
      Item.new(attrs.merge(item_attributes))
    end
  end
end
