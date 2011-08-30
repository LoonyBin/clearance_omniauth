$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clearance_omniauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clearance_omniauth"
  s.version     = ClearanceOmniauth::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ClearanceOmniauth."
  s.description = "TODO: Description of ClearanceOmniauth."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0.rc8"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
