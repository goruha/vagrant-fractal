$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'vagrant-fractal/version'

Gem::Specification.new do |s|
  s.name        = 'vagrant-fractal'
  s.version     = VagrantPlugins::Fractal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Igor Rodionov'
  s.email       = 'goruha@gmail.com'
  s.homepage    = 'http://github.com/goruha/vagrant-fractal'
  s.summary     = 'Allow to config Vagrant work with multiple docker boxes'
  s.description = 'Vagrant plugin to config multiple docker boxes'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'cucumber'
end
