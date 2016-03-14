require 'active_support/dependencies/autoload'
require 'play_store/config'

module PlayStore
  extend ActiveSupport::Autoload

  autoload :GooglePlay
  autoload :AppStore
  autoload :Item
  autoload :Review
  autoload :Crawler
end
