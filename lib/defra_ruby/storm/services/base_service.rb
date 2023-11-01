# frozen_string_literal: true

module DefraRuby
  module Storm
    class BaseService
      def self.run(attrs = {})
        new.run(**attrs)
      end
    end
  end
end
