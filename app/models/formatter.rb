class Formatter < ActiveRecord::Base
  validates :item, presence: true

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
    download_count_min: ->(shot) { shot.download_count_min.to_i },
    download_count_max: ->(shot) { shot.download_count_max.to_i },
    last_rank: nil
  }

  RANKING_HANDLERS = {
    platform: ->(ranking) { I18n.t ranking.platform, scope: 'platforms' },
    genre: nil,
    segment: nil,
    created_on: nil,
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
    text.gsub(/<<(\w+)(%.*?)?(\|.*?)?>>/) do
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
