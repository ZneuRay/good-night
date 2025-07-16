Apipie.configure do |config|
  config.app_name                = "Good Night API"
  config.app_info                = "Sleep tracking and social following API for Good Night application"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.default_version         = "v1"
  config.default_locale          = nil
  config.languages               = ['en']
  config.translate               = false
  config.validate                = false
  config.authenticate            = proc { false } # Set to true if you want to require authentication
  config.show_all_examples       = true
end
