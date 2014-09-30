require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tracktor
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib/tracktor)
    config.time_zone = 'Mountain Time (US & Canada)'
  end
end
