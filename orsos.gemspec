# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orsos/version'

Gem::Specification.new do |spec|
  spec.name          = "orsos"
  spec.version       = Orsos::VERSION
  spec.authors       = ["Jonathan Chang"]
  spec.email         = ["jonathan.chang@silverpond.com.au"]
  spec.summary       = %q{Oregon Secretary of State website (http://sos.oregon.gov/Pages/default.aspx) scraper}
  spec.description   = %q{A command line tool to download data from the Oregon Secretary of State website (http://sos.oregon.gov/Pages/default.aspx). Uses mechanize gem to post search requests to the website and download excel files.}
  spec.homepage      = "https://github.com/jonochang/orsos"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
