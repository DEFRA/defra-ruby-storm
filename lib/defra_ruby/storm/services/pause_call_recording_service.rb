# frozen_string_literal: true

module DefraRuby
  module Storm
    class PauseCallRecordingService < BaseService

      def run(username: nil, agent_user_id: nil)
        if agent_user_id.nil? && !username.nil?
          user_details = DefraRuby::Storm::UserDetailsService.run(username: username)
          agent_user_id = user_details&.user_id
        end

        raise ArgumentError, "You must provide either a username or a agent_user_id" if agent_user_id.nil?

        api_client = DefraRuby::Storm::API.new(DefraRuby::Storm::Configuration.call_recording_service_configuration)
        api_client.pause_call_recording(agent_user_id)
      end

    end
  end
end
