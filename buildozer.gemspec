# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'buildozer/version'

Gem::Specification.new do |gem|
  gem.name          = "buildozer"
  gem.version       = Buildozer::VERSION
  gem.authors       = ["Matthieu Vachon"]
  gem.email         = ["matthieu.o.vachon@gmail.com"]
  gem.homepage      = "https://github.com/maoueh/buildozer"
  gem.summary       = "Application to build and package software."
  gem.description   = <<-EOF
     Buildozer is an application that aims to ease the building
     and packaging of software.

     With this application, and with the help of the fpm library,
     you should be able to build and package any software like
     a breeze in a fully automatic manner.
  EOF

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "fpm", "~> 0.4.29"

  gem.add_development_dependency "rake", "~> 10.0.3"
end
