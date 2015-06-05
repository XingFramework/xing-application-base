require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LrdCms; end
APP_MODULE = LrdCms

module APP_MODULE
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    ###### COPIED FROM PREVIOUS VERSION OF XING in commit a0f7e416 #######

    #observers are define in app/observers
    config.active_record.observers = :sitemap_observer, :page_snapshot_observer

    config.filter_parameters += [:password, :pasword_confirmation]

    # Enable the asset pipeline
    config.assets.enabled = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    config.site_title = "LRD Content Management Engine"
    config.middleware.insert_before Rack::Runtime, Rack::Cors do
        allow do
            origins '*'
            resource '*',
            :headers => :any,
            :expose => ['Location', 'access-token', 'token-type', 'client', 'expiry', 'uid'],
            :methods => [:get, :post, :delete, :put, :patch, :options]
        end
    end
  end
end
