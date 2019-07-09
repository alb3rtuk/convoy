$LOAD_PATH << File.expand_path(File.join('..', 'lib'), __FILE__)

require 'date'

require_relative 'version'

Gem::Specification.new do |s|
    s.name          = 'convoy'
    s.version       = CONVOY_VERSION
    s.date          = Date.today.to_s
    s.summary       = %q{A library that makes building command line apps in ruby so easy, you'll feel like an expert is guiding you through it}
    s.description   = %q{Writing even complex command-line apps should be quick, easy and fun. Convoy takes the excellent Trollop option parser and adds a whole bunch of awesome features to produce a library you will always want to turn to when a 'quick script' is in order.}
    s.authors       = ['Albert Rannetsperger']
    s.email         = 'alb3rtuk@hotmail.com'
    s.homepage      = 'http://github.com/alb3rtuk/convoy'
    s.license       = 'MIT'
    s.require_paths = ['lib']
    s.files         = `git ls-files`.split($/)
    s.test_files    = s.files.grep(%r{^(test|spec|features)/})
    s.add_runtime_dependency 'nesty', '~> 1.0', '>= 1.0.2'
    s.add_runtime_dependency 'blufin-lib', '1.5.0', '>= 1.5.0'
    s.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
    s.add_development_dependency 'fakefs', '~> 0.5', '>= 0.5.3'
    s.add_development_dependency 'rake', '~> 10.3', '>= 10.3.2'
    s.add_development_dependency 'travis-lint', '~> 2.0', '>= 2.0.0'
    s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
end
