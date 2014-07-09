require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Pf
  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl
      g.view_specs false
      g.helper_specs false
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/pf)


    config.encoding = "utf-8"

    config.filter_parameters += [:password, :password_confirmation]

    config.active_support.escape_html_entities_in_json = true

    config.assets.version = '1.0'

    config.i18n.enforce_available_locales = true

    # For Heroku
    config.assets.initialize_on_precompile = false
  end
end
