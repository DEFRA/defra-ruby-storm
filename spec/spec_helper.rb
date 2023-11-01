# frozen_string_literal: true

require "defra_ruby/storm"
require "support/fixture_helper"

# Require and run our simplecov initializer as the very first thing we do.
# This is as per its docs https://github.com/colszowka/simplecov#getting-started
require "./spec/support/simplecov"

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# We make an exception for simplecov because that will already have been
# required and run at the very top of spec_helper.rb
support_files = Dir["./spec/support/**/*.rb"].reject { |file| file == "./spec/support/simplecov.rb" }
support_files.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FixtureHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
