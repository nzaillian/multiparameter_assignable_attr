$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multiparameter_assignable_attr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multiparameter_assignable_attr"
  s.version     = MultiparameterAssignableAttr::VERSION
  s.authors     = ["nzaillian"]
  s.email       = ["nzaillian@gmail.com"]
  s.homepage    = "https://github.com/nzaillian/multiparameter_assignable_attr"
  s.summary     = "Patch for multiparameter-wise assignment of transient (non-db-backed) model attributes in Rails' (Active Record)."
  s.description = "Patch for multiparameter-wise assignment of transient (non-db-backed) model attributes in Rails' (Active Record)."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "rspec", ">= 2"

  s.add_development_dependency "sqlite3"
end
