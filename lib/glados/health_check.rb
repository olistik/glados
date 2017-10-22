module Glados
  class HealthCheck
    THRESHOLD_DELTA = 60 * 2 # 2 minutes ago

    def initialize
      @time_threshold = Time.now.utc - THRESHOLD_DELTA
      @device_repo = DeviceRepository.new
      @heartbeat_repo = HeartbeatRepository.new
      @results = {
        late: [],
        up_to_date: [],
        not_init: [],
      }
    end

    def self.call
      new.perform
    end

    def perform
      @device_repo.not_late.each do |device|
        heartbeat = @heartbeat_repo.last_for_device(device: device)
        if heartbeat
          record = {
            device: device,
            heartbeat: heartbeat
          }
          if heartbeat.created_at < @time_threshold
            @results[:new_late] << record
          else
            @results[:up_to_date] << record
          end
        else
          @results[:not_init] << {device: device}
        end
      end
      update_new_late(devices: @results[:new_late])
      Result::Success(data: @results)
    end

    private

    def update_new_late(devices:)
      device_status_repo = DeviceStatusRepository.new
      device_status_repo.set_late(devices: devices)
    end
  end
end
