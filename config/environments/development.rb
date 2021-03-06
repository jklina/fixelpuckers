Pf::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # config.action_mailer.delivery_method = :smtp
  # # change to true to allow email to be sent during development
  # config.action_mailer.perform_deliveries = false
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default :charset => "utf-8"  

  #   config.action_mailer.smtp_settings = {
  #     :address   => "smtp.mandrillapp.com",
  #     :port      => 25,
  #     :user_name => ENV["MANDRILL_USERNAME"],
  #     :password  => ENV["MANDRILL_API_KEY"]
  #   }



  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
end
