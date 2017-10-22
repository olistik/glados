module Glados
  class CreateHeartbeat
    def initialize(device:, data:)
      @device = device
      @data = data
    end

    def call
      heartbeat_repo = HeartbeatRepository.new
      begin
        heartbeat = Heartbeat.new(
          device_id: @device.id,
          data: @data
        )
      rescue TypeError
        return Result::Error(code: :type_error)
      end
      result = heartbeat_repo.create(heartbeat)
      Result::Success(data: {id: result.id})
    end
  end
end
