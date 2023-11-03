# frozen_string_literal: true

require_relative "lib/defra_ruby/storm/version"

Gem::Specification.new do |spec|
  spec.name = "defra_ruby_storm"
  spec.version = DefraRuby::Storm::VERSION
  spec.authors = ["Defra"]
  spec.email = ["leonid.brujev@defra.gov.uk"]
  spec.license = "The Open Government Licence (OGL) Version 3"

  spec.summary = "Ruby client for Storm Web Services API"
  spec.homepage = "https://github.com/DEFRA/defra-ruby-storm"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DEFRA/defra-ruby-storm"
  spec.metadata["changelog_uri"] = "https://github.com/DEFRA/defra-ruby-storm/CHANGELOG.md"

  # SOAP client
  spec.add_dependency "savon", "~> 2.13.0"

  spec.require_paths = ["lib"]

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.metadata["rubygems_mfa_required"] = "true"
end
