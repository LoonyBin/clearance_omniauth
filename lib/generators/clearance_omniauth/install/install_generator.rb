require 'rails/generators/base'

module ClearanceOmniauth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
    end
  end
end
