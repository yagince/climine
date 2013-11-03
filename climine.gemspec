# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'climine/version'

Gem::Specification.new do |spec|
  spec.name          = "climine"
  spec.version       = Climine::VERSION
  spec.authors       = ["yagince"]
  spec.email         = ["straitwalk@gmail.com"]
  spec.description   = %q{CLI for Redmine}
  spec.summary       = %q{CLI for Redmine}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob("**/*").select{|path| !(path =~ /^doc|^pkg/) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1.0"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "redcarpet", "~> 3.0"
  spec.add_development_dependency "thor", "~> 0.18"
  spec.add_development_dependency "thor", "~> 0.18"
  spec.add_development_dependency "hashie", "~> 2.0.5"  
end
