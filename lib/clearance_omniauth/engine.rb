require 'clearance'
require 'omniauth'

module ClearanceOmniauth
  class Engine < Rails::Engine
    isolate_namespace ClearanceOmniauth
    config.clearance_http_auth = Configuration
  end
end
