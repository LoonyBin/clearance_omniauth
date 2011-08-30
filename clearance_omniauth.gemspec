$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clearance_omniauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clearance_omniauth"
  s.version     = ClearanceOmniauth::VERSION
  s.authors     = ["Subhash Chandra"]
  s.email       = ["TMaYaD+gems@gmail.com"]
  s.homepage    = "github.com/LoonyBin/clearance_omniauth"
  s.summary     = "mountable engine for omniauth for clearance"
  s.description = "TODO: Description of ClearanceOmniauth."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0.rc8"
  s.add_dependency "clearance"
  s.add_dependency "omniauth"

  s.add_development_dependency "sqlite3"
end
