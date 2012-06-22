# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heroku_environment/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Martin Provencher"]
  gem.email         = ["mprovencher86@gmail.com"]
  gem.description   = %q{This gem is used to easily manage your Heroku variable environment.}
  gem.summary       = %q{This gem is used to easily manage your Heroku variable environment.}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "heroku_environment"
  gem.require_paths = ["lib"]
  gem.version       = HerokuEnvironment::VERSION
end
