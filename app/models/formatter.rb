class Formatter < ActiveRecord::Base
  validates :item, presence: true

  ITEM_HANDLERS = {
    genre: nil,
    segment: nil,
    rank: nil,
    url: nil,
    title: nil,
    author: nil,
    price: ->(shot) { number_to_currency shot.price },
    image_url: nil,
    rating: ->(shot) { '%.1f' % shot.rating },
    rating_count: ->(shot) { number_to_delimited shot.rating_count },
    download_count_min:
      ->(shot) { number_to_delimited shot.download_count_min.to_i },
    download_count_max:
      ->(shot) { number_to_delimited shot.download_count_max.to_i },
    last_rank:
      ->(shot) { shot.last_rank || '--' }
  }

  RANKING_HANDLERS = {
    platform: ->(ranking) { I18n.t ranking.platform, scope: 'platforms' },
    genre: nil,
    segment: nil,
    created_on: ->(ranking) { I18n.l ranking.created_on, format: :explicit },
    items_count: ->(ranking) { ranking.shots.count }
  }

  extend ActiveSupport::NumberHelper

  def format ranking
    [
      format_ranking(ranking, :pre),
      *format_items(ranking),
      format_ranking(ranking, :post)
    ].join
  end

  def format_items ranking
    ranking.shots.map { |shot| format_item shot }
  end

  def format_item shot
    interpolate item, shot, ITEM_HANDLERS
  end

  def format_ranking ranking, attr_name
    return if self[attr_name].blank?
    interpolate self[attr_name], ranking, RANKING_HANDLERS
  end

  private

  def interpolate text, obj, handlers
    text.gsub(/<<(\w+)>>/) do
      fn = handlers[$1.to_sym] || ->(_) { obj.send $1 }
      fn.call obj
    end
  end
end
