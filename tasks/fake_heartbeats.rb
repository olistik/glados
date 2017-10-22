task fake_heartbeats: :environment do
  heartbeat_repo = HeartbeatRepository.new
  creation_time = Time.now.utc
  heartbeat_repo.create(
    device_id: 1,
    created_at: creation_time.strftime("%Y-%m-%d %H:%M:%S UTC"),
    data: {label: "dummy data"}
  )

  creation_time = Time.now.utc - 60 * 3
  heartbeat_repo.create(
    device_id: 2,
    created_at: creation_time.strftime("%Y-%m-%d %H:%M:%S UTC"),
    data: {label: "dummy data"}
  )
end
