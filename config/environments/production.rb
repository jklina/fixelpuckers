Pf::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.eager_load = true

  config.serve_static_files = false

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_level = :info

  config.action_mailer.default_url_options = { :host => 'pixelfuckers.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"  

  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 25,
    :user_name => ENV["MANDRILL_USERNAME"],
    :password  => ENV["MANDRILL_API_KEY"]
  }

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
end
