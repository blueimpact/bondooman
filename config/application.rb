require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Bondooman
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja]
    config.active_job.queue_adapter = :sidekiq
    config.active_record.default_timezone = :local
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.orm :active_record
      g.test_framework :rspec, fixture: true, fixture_replacement: :factory_girl
      g.view_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end
  end
end
