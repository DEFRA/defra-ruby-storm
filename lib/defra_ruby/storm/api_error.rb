# frozen_string_literal: true

module DefraRuby
  module Storm
    # Custom error class to handle Storm API errors
    class ApiError < StandardError
      def initialize(msg = "Storm API error")
        super
      end
    end
  end
end
