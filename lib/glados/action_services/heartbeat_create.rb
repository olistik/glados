require_relative "base"

module Glados
  module ActionService
    class HeartbeatCreate < Base
      def call
        result = JSONParseRequest.(request)
        return result if result.error?
        request_payload = result.data
        device_repo = DeviceRepository.new
        result = device_repo.find_by_name(params[:device_name])
        return result if result.error?
        device = result.data
        if device.secret_key != request_payload["deviceSecretKey"]
          return Result::Error(code: :wrong_device_secret_key)
        end
        service = ::Glados::CreateHeartbeat.new(
          device: device,
          data: request_payload["data"]
        )
        service.perform
      end
    end
  end
end
