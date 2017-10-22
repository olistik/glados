class DeviceStatusRepository < Hanami::Repository
  associations do
    belongs_to :device
  end

  def ids
    device_statuses.pluck(:id)
  end

  def query(conditions)
    device_statuses.where(conditions)
  end

  def find_by_device(device:)
    device_statuses.
      where(device_id: device.id).
      limit(1).
      one
  end

  def all_with_device_ids(device_ids:)
    device_statuses.
      where(device_id: device_ids).
      to_a
  end

  def set_late(devices:)
    scope = device_statuses.where(device_id: devices.map(&:id))
    command(:update, device_statuses, result: :many).new(scope).call({status: "late"})
  end

  def set_ok(devices:)
    # command(:update, device_statuses.where(device_id: devices.to_a.map(&:id)), result: :many).call({status: "ok"})
    scope = device_statuses.where { device_id.in([7, 8]) }
    command(:update, scope, result: :many).call({status: "ok"})
  end
end
