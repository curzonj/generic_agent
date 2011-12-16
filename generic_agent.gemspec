# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "generic_agent/version"

Gem::Specification.new do |s|
  s.name        = "generic_agent"
  s.version     = GenericAgent::VERSION
  s.authors     = ["Jordan Curzon"]
  s.email       = ["curzonj@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{generic agent}
  s.description = %q{a framework to daemonize and do things}

  s.rubyforge_project = "generic_agent"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "eventmachine"
  s.add_runtime_dependency "thor"
end
