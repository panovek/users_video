require 'dragonfly'

# Configure
Dragonfly.app.configure do
  #plugin :imagemagick

  verify_urls true
  secret "b0959613602e7f46f64b6687974b055e423465f0458a0579b3796af1473df013"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')

end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
