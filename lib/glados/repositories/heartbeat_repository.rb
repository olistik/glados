class HeartbeatRepository < Hanami::Repository
  def last_for_device(device:)
    for_device(device: device).
      order(Sequel.desc(:created_at)).
      limit(1).
      one
  end

  def count_for_device(device:)
    for_device(device: device).count
  end

  def for_device(device:)
    heartbeats.where(device_id: device.id)
  end
end
