lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "squid_analyzer/version"

Gem::Specification.new do |spec|
  spec.name          = "squid_analyzer"
  spec.version       = SquidAnalyzer::VERSION
  spec.authors       = ["r7kamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Data analyzer for Splatoon."
  spec.homepage      = "https://github.com/r7kamura/squid_analyzer"
  spec.license       = "MIT"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby-opencv"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
end
