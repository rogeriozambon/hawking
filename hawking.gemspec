$:.push File.expand_path("../lib", __FILE__)
require "hawking"

Gem::Specification.new do |s|
  s.name          = "hawking"
  s.version       = Hawking::VERSION
  s.platform      = Gem::Platform::RUBY

  s.authors       = ["Rogério Zambon"]
  s.email         = ["rogeriozambon@gmail.com"]
  s.homepage      = "http://github.com/rogeriozambon/hawking"
  s.summary       = "Background job queueing using Socket. Inspired in the Stalkeg gem."
  s.description   = s.summary
  s.license       = "MIT"

  s.executables   = ["hawking"]

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "json_pure"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
