# frozen_string_literal: true

require "savon"

require_relative "storm/version"
require_relative "storm/configuration"
require_relative "storm/api"
require_relative "storm/api_error"

require_relative "storm/services/base_service"
require_relative "storm/services/user_details_service"
require_relative "storm/services/pause_call_recording_service"
require_relative "storm/services/resume_call_recording_service"

require_relative "storm/responses/base_response"
require_relative "storm/responses/get_user_details_response"
require_relative "storm/responses/recording_response"

module DefraRuby
  module Storm
    class << self
      # attr_accessor :configuration

      def configure
        yield(configuration)
      end

      def configuration
        @configuration ||= Configuration.new
        @configuration
      end
    end
  end
end
