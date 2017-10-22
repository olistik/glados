class DeviceRepository < Hanami::Repository
  associations do
    has_many :heartbeats
    has_one :device_status
  end

  def ids
    device_statuses.pluck(:id)
  end

  def query(conditions)
    device_statuses.where(conditions)
  end

  def find_by_name(name)
    data = devices.where(name: name).first
    if data
      Result::Success(data: data)
    else
      Result::Error(code: :device_not_found)
    end
  end

  def not_late
    aggregate(:device_status).
      join(:device_statuses).
      where(device_statuses[:status].qualified.not("late")).
      as(DeviceStatus)
  end
end
