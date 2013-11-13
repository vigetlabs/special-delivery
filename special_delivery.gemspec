$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "special_delivery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "special_delivery"
  s.version     = SpecialDelivery::VERSION
  s.authors     = ["Lawson Kurtz"]
  s.email       = ["lawson.kurtz@viget.com"]
  s.homepage    = "http://viget.com"
  s.summary     = "Summary of SpecialDelivery."
  s.description = "Description of SpecialDelivery."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "pry"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "simplecov"

end
