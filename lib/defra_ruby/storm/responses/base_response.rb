# frozen_string_literal: true

require "ostruct"

module DefraRuby
  module Storm
    class BaseResponse
      def initialize(args)
        args.each do |key, value|
          next if key == :@xmlns

          instance_variable_set("@#{key}", value)
        end
      end
    end
  end
end
