require "securerandom"

module Glados
  class CreateDevice
    def initialize(device_name:)
      @device_name = device_name
    end

    def call
      repo = DeviceRepository.new
      result = repo.find_by_name(@device_name)
      if result.success?
        return Result::Error(code: :device_name_already_registered)
      end
      begin
        device = Device.new(
          name: @device_name,
          secret_key: SecureRandom.hex
        )
      rescue TypeError
        return Result::Error(code: :type_error)
      end
      begin
        device = repo.create(device)
      rescue Hanami::Model::Error => error
        Result::Error(code: :repository_create_failure, data: error)
      end
      device_status_repo = DeviceStatusRepository.new
      begin
        device_status = device_status_repo.create(device_id: device.id)
      rescue Hanami::Model::Error => error
        Result::Error(code: :repository_create_failure, data: error)
      end
      data = {
        name: device.name,
        secret_key: device.secret_key,
        status: device_status.status,
      }
      Result::Success(data: data)
    end
  end
end
