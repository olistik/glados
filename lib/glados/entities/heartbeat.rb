class Heartbeat < Hanami::Entity
  attributes do
    attribute :id, Types::Strict::Int
    attribute :device_id, Types::Strict::Int
    attribute :data, Types::Json::Hash
    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def formatted_time
    created_at.utc.strftime("%Y-%m-%d %H:%M:%S UTC")
  end
end
