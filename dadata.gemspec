# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dadata/version'

Gem::Specification.new do |spec|
  spec.name = 'dadata'
  spec.version = Dadata::VERSION
  spec.authors = ['Rinat Garifullin']
  spec.email = ['ringarifullin@gmail.com']

  spec.summary = 'Dadata.ru API integration'
  spec.homepage = 'https://github.com/rgarifullin/dadata'
  spec.license = 'MIT'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => 'https://github.com/rgarifullin/dadata/blob/master/CHANGELOG.md'
  }

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.17', '< 3.0'
  spec.add_development_dependency 'ffaker', '~> 2.13'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 1.3'
  spec.add_development_dependency 'webmock', '~> 3.7'
end
