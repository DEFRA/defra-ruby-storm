# frozen_string_literal: true

module DefraRuby
  module Storm
    class UserDetailsService < BaseService
      def run(username:)
        api_client = DefraRuby::Storm::API.new(DefraRuby::Storm::Configuration.user_details_service_configuration)
        api_client.get_user_details(username)
      end
    end
  end
end
