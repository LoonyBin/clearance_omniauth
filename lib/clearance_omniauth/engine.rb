require 'clearance'
require 'omniauth'

module ClearanceOmniauth
  class Engine < Rails::Engine
    isolate_namespace ClearanceOmniauth

    config.clearance_omniauth = Configuration

    # OmniAuth 2.x requires CSRF protection configuration
    initializer "clearance_omniauth.omniauth_csrf" do
      OmniAuth.config.allowed_request_methods = [:post, :get]
    end
  end
end
