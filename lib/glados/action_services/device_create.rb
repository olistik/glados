require_relative "base"

module Glados
  module ActionService
    class DeviceCreate < Base
      def call
        result = ::Glados::JSONParseRequest.(request)
        return result if result.error?
        request_payload = result.data
        result = ::Glados::ValidateAPIKey.(request_payload["apiKey"])
        return result if result.error?
        service = ::Glados::CreateDevice.new(device_name: request_payload["data"]["name"])
        service.call
      end
    end
  end
end
