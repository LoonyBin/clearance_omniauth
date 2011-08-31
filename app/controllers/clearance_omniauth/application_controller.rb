module ClearanceOmniauth
  class ApplicationController < ActionController::Base
    include Clearance::Authentication
  end
end
