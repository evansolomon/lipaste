# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lipaste/version"

Gem::Specification.new do |spec|
  spec.name          = "lipaste"
  spec.version       = Lipaste::VERSION
  spec.authors       = ["Evan Solomon"]
  spec.email         = ["evan@evanalyze.com"]

  spec.summary       = %q{Upload PGN files to Lichess analysis service.}
  spec.description   = %q{Upload PGN from files or strings to Lichess via the CLI.}
  spec.homepage      = "https://github.com/evansolomon/lipaste"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_dependency 'thor', '~> 0.19.1'
end
