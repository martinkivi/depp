$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "depp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "depp"
  s.version     = Depp::VERSION
  s.authors     = ["Priit Tark", "Martin Lensment"]
  s.email       = ["priit@gitlab.eu", "martin@gitlab.eu"]
  s.homepage    = "https://github.com/domify/depp"
  s.summary     = "EPP/REPP client build as Rails engine."
  s.description = "EPP/REPP client build as Rails engine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  # s.add_development_dependency "sqlite3"
end
