require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MovieDb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.paths.add Rails.root.join('lib', 'api').to_s, eager_load: true

    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:              'in-v3.mailjet.com',
      port:                 587,
      domain:               'gmail.com',
      user_name:            'b91092626b56c515d94779e8d036e247',
      password:             'c1d4fb89c4abc65866ec35db8deffcb2',
      # authentication:       :plain,
      enable_starttls_auto: true
    }
  end
end
