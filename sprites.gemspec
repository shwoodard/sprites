# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sprites/version"

Gem::Specification.new do |s|
  s.name        = "sprites"
  s.version     = Sprites::VERSION
  s.authors     = ["Sam Woodard"]
  s.email       = ["sam@activecodebase.com"]
  s.homepage    = "https://github.com/shwoodard/sprites"
  s.summary     = %q{Sprites generator for ruby applications or from cli}
  s.description = %q{Sprites generator for ruby applications or from cli}

  s.rubyforge_project = "sprites"

  files = `git ls-files`.split("\n")
  s.files         = files
  s.test_files    = files.find_all { |path| path =~ /^(test,spec,features)/ }
  s.executables   = files.find_all { |path| path =~ /^bin/ }.map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rmagick"
  s.add_development_dependency 'css_parser', '~>1.1.5'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rails'

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "oily_png"
end
