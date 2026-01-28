$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clearance_omniauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clearance_omniauth"
  s.version     = ClearanceOmniauth::VERSION
  s.authors     = ["Subhash Chandra"]
  s.email       = ["TMaYaD+gemcutter@gmail.com"]
  s.homepage    = "http://github.com/LoonyBin/clearance_omniauth"
  s.summary     = "Mountable engine for OmniAuth integration with Clearance"
  s.description = "Pluggable Rails engine for using OmniAuth with Clearance authentication"
  s.license     = "MIT"

  s.required_ruby_version = ">= 3.0.0"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 7.0", "< 9.0"
  s.add_dependency "clearance", ">= 2.0"
  s.add_dependency "omniauth", ">= 2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
