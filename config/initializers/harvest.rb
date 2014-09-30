module Harvest
  CONFIGURATION_FILE = Rails.root.join('config', "harvest.yml")

  if File.exist?(CONFIGURATION_FILE)
    begin
      harvest_app_config = YAML.load_file(CONFIGURATION_FILE).fetch(Rails.env).with_indifferent_access

      ENV["HARVEST_CLIENT_ID"]     = harvest_app_config.fetch(:client_id)
      ENV["HARVEST_CLIENT_SECRET"] = harvest_app_config.fetch(:client_secret)
      ENV["HARVEST_REDIRECT_URI"]  = harvest_app_config.fetch(:redirect_uri)

    rescue KeyError
      abort "Harvest app configuration incomplete. :client_id, :client_secret, and :redirect_uri must be provided. For a basic version, run:\n\n    cp config/harvest.yml.example config/harvest.yml"
    end
  end

  begin
    CLIENT_ID     = ENV.fetch("HARVEST_CLIENT_ID")
    CLIENT_SECRET = ENV.fetch("HARVEST_CLIENT_SECRET")
    REDIRECT_URI  = ENV.fetch("HARVEST_REDIRECT_URI")
  rescue KeyError
    abort "Harvest app configuration not found. Set ENV['HARVEST_CLIENT_ID'], ENV['HARVEST_CLIENT_SECRET'], and ENV['HARVEST_REDIRECT_URI'] or run:\n\n    cp config/harvest.yml.example config/harvest.yml"
  end
end
