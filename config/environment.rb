# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MovieNight::Application.initialize!

OEmbed::Providers.register_all()
OEmbed::Providers.register_fallback(OEmbed::ProviderDiscovery, OEmbed::Providers::Embedly, OEmbed::Providers::OohEmbed)

pusher = YAML.load_file(File.join(Rails.root, 'config','pusher.yml'))
Pusher.app_id = pusher['app_id']
Pusher.key    = pusher['key']
Pusher.secret = pusher['secret']
Pusher.logger = Rails.logger
