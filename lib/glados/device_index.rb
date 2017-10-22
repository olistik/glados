module Glados
  class DeviceIndex
    def call
      device_repository = DeviceRepository.new
      heartbeat_repository = HeartbeatRepository.new
      device_status_repository = DeviceStatusRepository.new
      devices = device_repository.all.map do |device|
        heartbeats_count = heartbeat_repository.count_for_device(device: device)
        status = device_status_repository.find_by_device(device: device).status
        {
          name: device.name,
          secret_key: device.secret_key,
          heartbeats_count: heartbeats_count,
          status: status,
        }
      end
      # TODO: catch previous errors
      Result::Success(data: devices)
    end
  end
end
