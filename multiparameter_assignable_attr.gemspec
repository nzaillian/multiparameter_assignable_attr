$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multiparameter_assignable_attr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multiparameter_assignable_attr"
  s.version     = MultiparameterAssignableAttr::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "Patch for multiparameter-wise assignment of transient (non-db-backed) model attributes."
  s.description = "Patch for multiparameter-wise assignment of transient (non-db-backed) model attributes."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "rspec", ">= 2"

  s.add_development_dependency "sqlite3"
end
