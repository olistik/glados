require_relative "base"

module Glados
  module ActionService
    class DeviceIndex < Base
      def call
        result = ::Glados::JSONParseRequest.(request)
        error(code: result.code) if result.error?
        request_payload = result.data
        result = ::Glados::ValidateAPIKey.(request_payload["apiKey"])
        error(code: result.code) if result.error?
        result = ::Glados::DeviceIndex.new.call
        error(code: result.code) if result.error?
        success payload: result.data
      end
    end
  end
end
