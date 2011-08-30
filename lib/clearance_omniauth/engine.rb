require 'clearance'
require 'omniauth'

module ClearanceOmniauth
  class Engine < Rails::Engine
    isolate_namespace ClearanceOmniauth
  end
end
