lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'witei_web_api/version'

Gem::Specification.new do |spec|
  spec.name = 'witei_web_api'
  spec.version = WiteiWebApi::VERSION
  spec.authors = ['Dmitry Polushkin']
  spec.email = ['dmitry.polushkin@gmail.com']

  spec.summary = %q{Witei Web API}
  spec.description = %q{Witei Web API}
  spec.homepage = 'https://github.com/dmitry/witei_web_api'
  spec.license = 'CC0-1.0'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15', '>= 1.15.4'
  spec.add_development_dependency 'rake', '~> 12.1', '>= 12.1.0'
  spec.add_development_dependency 'minitest-proveit', '~> 1.0', '>= 1.0.0'
  spec.add_development_dependency 'minitest', '~> 5.9', '>= 5.9.0'
  spec.add_development_dependency 'minitest-line', '~> 0.6', '>= 0.6.3'
  spec.add_development_dependency 'webmock', '~> 3.0', '>= 3.0.1'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'simplecov', '~> 0.11', '>= 0.11.2'
  spec.add_development_dependency 'yard', '~> 0.9', '>= 0.9.11'
  # spec.add_development_dependency 'pry', '~> 0.10', '>= 0.10.3'

  spec.add_dependency 'mechanize', '~> 2.7'
  spec.add_dependency 'activemodel', '~> 5.0'
end
