$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rent_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rent_search"
  s.version     = RentSearch::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RentSearch."
  s.description = "TODO: Description of RentSearch."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  # s.add_dependency "jquery-rails"
end
