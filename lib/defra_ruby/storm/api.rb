# frozen_string_literal: true

module DefraRuby
  module Storm
    class API
      def initialize(config = DefraRuby::Storm::Configuration.call_recording_service_configuration)
        @client = ::Savon.client(config)
      end

      def get_user_details(username)
        response = @client.call(:get_user_details, message: { "ngw:UserName": "CarrierTest" },
                                                   message_tag: :getUserDetailsRequest)
        unless response.http.code == 200 && response.body[:get_user_details_response][:code] == "0"
          handle_error "Failed to get user details for username: #{username}"
        end

        DefraRuby::Storm::GetUserDetailsResponse.new(response.body[:get_user_details_response])
      end

      def pause_call_recording(agent_user_id)
        response = @client.call("RedCentrexCalls/Recording",
                                message: { "cal:UserID": agent_user_id, "cal:Record": "pause", "cal:Muted": "0" },
                                message_tag: :RecordingRequest)
        unless response.http.code == 200 && response.body[:recording_response][:result] == "0"
          handle_error "Failed to pause call recording for agent_user_id: #{agent_user_id}"
        end

        DefraRuby::Storm::RecordingResponse.new(response.body[:recording_response])
      end

      def resume_call_recording(agent_user_id)
        response = @client.call("RedCentrexCalls/Recording",
                                message: { "cal:UserID": agent_user_id, "cal:Record": "resume" },
                                message_tag: :RecordingRequest)
        unless response.http.code == 200 && response.body[:recording_response][:result] == "0"
          handle_error "Failed to resume call recording for agent_user_id: #{agent_user_id}"
        end

        DefraRuby::Storm::RecordingResponse.new(response.body[:recording_response])
      end

      def handle_error(error_message)
        raise ApiError, error_message
      end
    end
  end
end
