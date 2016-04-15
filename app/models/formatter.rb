class Formatter < ActiveRecord::Base
  validates :item_body, presence: true

  ITEM_HANDLERS = {
    rank: nil,
    url: nil,
    title: nil,
    author: nil,
    price: nil,
    image_url: nil,
    rating: nil,
    rating_count: nil,
    download_count_min: nil,
    download_count_max: nil,
    last_rank: nil
  }

  RANKING_HANDLERS = {
    platform: nil,
    genre: nil,
    segment: nil,
    created_on: nil,
    items_count: nil
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
    interpolate item_body, item
  end

  def format_ranking ranking, attr_name
    return if self[attr_name].blank?
    interpolate self[attr_name], ranking
  end

  private

  def handlers_for obj
    case obj
    when Item
      ITEM_HANDLERS
    when Ranking
      RANKING_HANDLERS
    end
  end

  def handle obj, key
    key = key.to_sym
    (handlers_for(obj)[key] || ->(o) { o.send key }).call(obj)
  end

  def interpolate text, obj
    drop_nil_lines(text, obj).gsub(/{{(\w+)(%.*?)?(\|.*?)?}}/) do
      val = handle(obj, $1)
      if val.nil? && $3
        $3[1..-1]
      elsif $2
        apply_format $2, val
      else
        val
      end
    end
  end

  def drop_nil_lines text, obj
    text.gsub(/^(\w+)(!)?\?(.*(\n|$))/) do
      if $2
        handle(obj, $1) ? '' : $3
      else
        handle(obj, $1) ? $3 : ''
      end
    end
  end

  def apply_format fmt, val
    if fmt =~ /^%(to_\w*)/
      ActiveSupport::NumberHelper.send "number_#{fmt[1..-1]}", val
    elsif val.respond_to? :strftime
      val.strftime fmt
    else
      fmt % val
    end
  end
end
