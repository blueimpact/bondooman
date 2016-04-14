class Formatter < ActiveRecord::Base
  validates :item_body, presence: true

  ITEM_HANDLERS = {
    genre: nil,
    segment: nil,
    rank: nil,
    url: nil,
    title: nil,
    author: nil,
    price: nil,
    image_url: nil,
    rating: nil,
    rating_count: nil,
    download_count_min: ->(item) { item.download_count_min.to_i },
    download_count_max: ->(item) { item.download_count_max.to_i },
    last_rank: nil
  }

  RANKING_HANDLERS = {
    platform: ->(ranking) { I18n.t ranking.platform, scope: 'platforms' },
    genre: nil,
    segment: nil,
    created_on: nil,
    items_count: ->(ranking) { ranking.items.count }
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
    ranking.items.map { |item| format_item item }
  end

  def format_item item
    interpolate item_body, item, ITEM_HANDLERS
  end

  def format_ranking ranking, attr_name
    return if self[attr_name].blank?
    interpolate self[attr_name], ranking, RANKING_HANDLERS
  end

  private

  def interpolate text, obj, handlers
    text.gsub(/{{(\w+)(%.*?)?(\|.*?)?}}/) do
      key = $1.to_sym
      arg = $2
      fn = handlers[key] || ->(_) { obj.send key }
      val = fn.call(obj)
      if val.nil? && $3
        $3[1..-1]
      elsif arg
        apply arg, val
      else
        val
      end
    end
  end

  def apply fmt, val
    if fmt =~ /^%(to_\w*)/
      ActiveSupport::NumberHelper.send "number_#{fmt[1..-1]}", val
    elsif val.respond_to? :strftime
      val.strftime fmt
    else
      fmt % val
    end
  end
end
